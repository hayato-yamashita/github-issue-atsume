class Api::Github
  class << self
    def repos_issues(owner: , repo:, page:)
      latest_response = Rails.cache.read(__method__)

      response = connection.get("/repos/#{owner}/#{repo}/issues", {page: page}) do |request|
        # see: https://developer.github.com/v3/#conditional-requests
        if latest_response
          request.headers['If-None-Match'] = latest_response.env.response_headers[:etag]
        end
      end

      case response.status
      when 304
        # 304 Not Modified だと body が空で返ってくるので最新レスポンスから補完
        response.env.body = latest_response.env.body
      end

      Rails.cache.fetch("latest_response", expired_in: 1.hour) do
        response
      end
    end

    def rate_limit?(response)
      response.status === 403 && response.env.response_headers["x-ratelimit-remaining"] == 0
    end

    private

      def connection
        @connection ||= Faraday.new(url: "https://api.github.com") do |builder|
          builder.response :logger, Rails.logger
          builder.adapter Faraday.default_adapter
        end
      end
  end
end
