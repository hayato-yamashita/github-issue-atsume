FactoryBot.define do
  factory :github_issue, class: 'Github::Issue' do
    github_repository { nil }
    title { "MyString" }
    body { "MyText" }
    html_url { "MyString" }
  end
end
