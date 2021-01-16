module Admin
  class BaseService
    attr_reader :connection

    def initialize(url, params)
      @connection = Faraday.new(
        url: url,
        params: params
      )
    end
  end
end
