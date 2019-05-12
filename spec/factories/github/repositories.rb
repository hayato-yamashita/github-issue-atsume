FactoryBot.define do
  factory :github_repository, class: 'Github::Repository' do
    owner { "MyString" }
    repo { "MyString" }
  end
end
