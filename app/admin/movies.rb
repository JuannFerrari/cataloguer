ActiveAdmin.register Movie do
  form partial: 'form'

  collection_action :search, method: :get do
    response = Faraday.get "http://www.omdbapi.com/?apikey=#{ENV['OMDB_API']}&t=#{params[:search]}&plot=full"
    response_body = JSON.parse(response.body).symbolize_keys
    respond_to do |format|
      format.json do
        render json: [{ id: response_body[:imdbID], text: response_body[:Title] }]
      end
    end
  end
end
