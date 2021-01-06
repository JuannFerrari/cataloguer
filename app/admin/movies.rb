PERMITTED_PARAMS = (Movie.attribute_names - %w[id created_at updated_at]).freeze

ActiveAdmin.register Movie do
  form partial: 'base_form'
  permit_params Movie.attribute_names - %w[id created_at updated_at]

  collection_action :search, method: :get do
    response = Admin::OmdbService.call(params[:search_term], params[:search_year]) if params[:search_term].present?
    respond_to do |format|
      format.json do
        render json: response
      end
    end
  end

  collection_action :build, method: :post do
    form = MovieForm.new(JSON.parse(params[:imdb_data]).slice(*PERMITTED_PARAMS))
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('movie-form', partial: 'admin/movies/form',
                                                                locals: { movie: form.movie })
      end
    end
  end

  controller do
    def create
      form = MovieForm.new(permitted_params[:movie])
      if form.save
        redirect_to [:admin, form.movie]
      else
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace('movie-form', partial: 'admin/movies/form',
                                                                    locals: { movie: form.movie })
          end
        end
      end
    end
  end
end
