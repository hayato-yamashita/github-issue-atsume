class Github::Issue < ApplicationRecord
  belongs_to :repository, class_name: 'Github::Repository', foreign_key: :github_repository_id

  FETCH_COUNT = 5
end
