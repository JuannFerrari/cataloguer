ActiveAdmin.register Movie do
  form partial: 'base_form'

  collection_action :search, method: :get do
    response = Admin::OmdbService.call(params[:search_term], params[:search_year]) if params[:search_term].present?
    respond_to do |format|
      format.json do
        render json: response
      end
    end
  end

  collection_action :build, method: :post do
    #make a builder service
    #restyle form
    data = JSON.parse(params[:imdb_data])
    attribute_names = Movie.column_names - %w[id created_at updated_at viewed_at
                                              my_score] #move this to permitted attriubutes

    movie = Movie.new(data.slice(*attribute_names))
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('movie-form', partial: 'admin/movies/form',
                                                                locals: { movie: movie })
      end
    end
  end
end
