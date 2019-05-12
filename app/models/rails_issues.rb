class RailsIssues
  class << self
    def puts_csv(page:)
      response = Api::Github.repos_issues(owner: "rails", repo: "rails", page: page)

      if response.success?
        puts_success(response)
      else
        puts_error(response)
      end
    end

    private

      def puts_success(response)
        issues = JSON.parse(response.env.body)
        csv = GithubIssue.new(issues).to_csv

        puts csv
      end

      def puts_error(response)
        error_info = {
          "url": response.env.url.to_s,
          "status": response.status,
          "headers": response.env.response_headers,
          "body": response.body,
        }

        puts "[Error]"
        puts error_info.to_yaml
      end
  end
end
