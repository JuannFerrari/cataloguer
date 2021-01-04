module Admin
  class OmdbService < BaseService
    def self.call(search_term)
      new(search_term).send(:search_movie)
    end

    def initialize(search_term)
      params = { t: search_term,
                 plot: 'full',
                 apikey: ENV['OMDB_API']
               }
      url = "http://www.omdbapi.com/?apikey=#{ENV['OMDB_API']}"
      super(url, params)
    end

    private

    def search_movie
      JSON.parse(connection.get.body)
          .transform_keys! { |key| key.downcase.to_sym }
    end
  end
end
