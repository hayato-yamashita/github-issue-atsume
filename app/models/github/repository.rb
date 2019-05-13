class Github::Repository < ApplicationRecord
  has_many :issues, class_name: 'Github::Issue', foreign_key: :github_repository_id, dependent: :destroy

  validates :owner, presence: true
  validates :repo, presence: true
  validates_uniqueness_of :owner, scope: [:repo]

  def display_name
    @display_name ||= self.class.display_name(owner, repo)
  end

  def html_url
    @html_url ||= self.class.html_url(owner, repo)
  end

  def refresh_issues
    begin
      response = Api::Github.repos_issues(owner: owner, repo: repo, page: 1, per_page: Github::Issue::FETCH_COUNT)
      return false unless response.success?

      res_issues = JSON.parse(response.env.body)
      hash_issues = GithubIssue.new(res_issues).to_hash

      # NOTE: 最大件数を考えて bulk でないことを許容する
      self.transaction do
        issues.each(&:destroy!)
        issues.create!(hash_issues)
      end

      return true
    rescue => e
      logger.error e
    end

    false
  end

  class << self
    def display_name(owner, repo)
      "#{owner} / #{repo}"
    end

    def html_url(owner, repo)
      "https://github.com/#{owner}/#{repo}/"
    end
  end
end
