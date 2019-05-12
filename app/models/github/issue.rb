class Github::Issue < ApplicationRecord
  belongs_to :repository, class_name: 'Github::Repository'
end
