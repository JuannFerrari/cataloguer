module Admin
  class OmdbService < BaseService
    OMDB_API = ENV['OMDB_API']

    def self.call(search_term, search_year)
      new(search_term, search_year).send(:search_movie)
    end

    def initialize(search_term, search_year)
      params = { t: search_term,
                 y: search_year,
                 plot: 'full',
                 apikey: OMDB_API }
      url = "http://www.omdbapi.com/?apikey=#{OMDB_API}"
      super(url, params)
    end

    private

    def search_movie
      JSON.parse(connection.get.body)
          .transform_keys! { |key| key.downcase.to_sym }
    end
  end
end
