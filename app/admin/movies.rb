ActiveAdmin.register Movie do
  permit_params MOVIE_PERMITTED_PARAMS

  form partial: 'base_form'

  show do
    attributes_table do
      row :id
      row :imdbid
      row :title
      row :year
      row :runtime
      row :released
      row :director
      row :writer
      row :language
      row :country
      row :genre
      row :rated
      row :imdbrating
      row :metascore
      row :awards
      row :actors
      row :plot

      panel 'My Info' do
        table_for movie do
          column :my_score
          column :month_viewed
          column :year_viewed
        end
      end
    end
  end

  sidebar 'Poster', only: :show do
    table_for movie do
      column do |ad|
        image_tag ad.poster
      end
    end
  end

  index do
    id_column
    column :title
    column :year
    column :imdbrating
    column :director
    column :my_score
    column :month_viewed
    column :year_viewed
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
    movie = Movie.new(JSON.parse(params[:imdb_data]).slice(*MOVIE_PERMITTED_PARAMS))
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('movie-form', partial: 'admin/movies/form',
                                                                locals: {
                                                                  movie: movie,
                                                                  url: admin_movies_path
                                                                })
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
                                                                    locals: {
                                                                      movie: movie,
                                                                      url: admin_movies_path
                                                                    })
          end
        end
      end
    end
  end
end
