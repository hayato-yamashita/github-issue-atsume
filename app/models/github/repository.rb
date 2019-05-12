class Github::Repository < ApplicationRecord
  has_many :issues, class_name: 'Github::Issue', :dependent => :destroy

  validates_uniqueness_of :owner, scope: [:repo]
end
