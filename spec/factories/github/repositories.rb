FactoryBot.define do
  factory :github_repository, class: 'Github::Repository' do
    owner { "MyOwner" }
    repo { "MyRepo" }

    trait :invalid do
      owner { nil }
      repo { nil }
    end
  end
end
