namespace :rails_issues do
  desc "Puts GitHub rails/rails issues"
  task :puts_csv => :environment do
    RailsIssues.puts_csv(page: 1)
  end
end
