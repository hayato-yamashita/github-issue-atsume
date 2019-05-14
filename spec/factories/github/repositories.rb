FactoryBot.define do
  factory :github_repository, class: 'Github::Repository' do
    owner { "MyString" }
    repo { "MyString" }

    trait :invalid do
      owner { nil }
      repo { nil }
    end
  end
end
