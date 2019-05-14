FactoryBot.define do
  factory :github_issue, class: 'Github::Issue' do
    repository { nil }
    title { "MyTitle" }
    body { "MyBody" }
    html_url { "MyUrl" }
  end
end
