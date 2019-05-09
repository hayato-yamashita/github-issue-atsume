namespace :rails_issues do
  desc "Fetch GitHub rails/rails issues"
  task :fetch => :environment do
    response = Api::Github.repos_issues(owner: "rails", repo: "rails", page: 1)

    puts "body:"
    JSON.parse(response.env.body).each {|record| puts "  - #{record}" }
  end
end
