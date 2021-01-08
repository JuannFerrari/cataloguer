PERMITTED_PARAMS = (Movie.attribute_names - %w[id created_at updated_at]).freeze

ActiveAdmin.register Movie do
  form partial: 'base_form'
  permit_params PERMITTED_PARAMS

  index do
    id_column
    column :title
    column :year
    column :imdbrating
    column :my_score
    column :director
    actions
  end

  filter :title
  filter :year
  filter :imdbrating
  filter :my_score
  filter :director
  filter :year_viewed
  filter :month_viewed

  collection_action :search, method: :get do
    if params[:search_term].present?
      response = Admin::OmdbService.call(params[:search_term], params[:search_year])
    end
    respond_to do |format|
      format.json do
        render json: response
      end
    end
  end

  collection_action :build, method: :post do
    movie = Movie.new(JSON.parse(params[:imdb_data]).slice(*PERMITTED_PARAMS))
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('movie-form', partial: 'admin/movies/form',
                                                                locals: { movie: movie })
      end
    end
  end

  controller do
    def create
      movie = Movie.new(permitted_params[:movie])
      if movie.save
        redirect_to([:admin, movie])
      else
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace('movie-form', partial: 'admin/movies/form',
                                                                    locals: { movie: movie })
          end
        end
      end
    end
  end
end
