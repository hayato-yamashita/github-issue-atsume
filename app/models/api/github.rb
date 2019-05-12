class Api::Github
  class << self
    def repos_issues(owner:, repo:, page:)
      connection.get("/repos/#{owner}/#{repo}/issues", {page: page})
    end

    private

      def connection
        @connection ||= Faraday.new(url: "https://api.github.com") do |builder|
          builder.use :http_cache, store: Rails.cache, serializer: Marshal, logger: Rails.logger
          builder.response :logger, Rails.logger
          builder.adapter Faraday.default_adapter
        end
      end
  end
end
