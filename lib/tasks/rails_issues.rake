namespace :rails_issues do
  desc "Fetch GitHub rails/rails issues"
  task :fetch => :environment do
    response = Api::Github.repos_issues(owner: "rails", repo: "rails", page: 1)
    issues = JSON.parse(response.env.body)
    csv = GithubIssue.new(issues).to_csv

    puts csv
  end
end
