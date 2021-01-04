ActiveAdmin.register Movie do
  form partial: 'form'

  collection_action :search, method: :get do
    response = Admin::OmdbService.call(params[:search_term])
    respond_to do |format|
      format.json do
        render json: [{ id: response[:imdbid], text: response[:title] }]
      end
    end
  end
end
