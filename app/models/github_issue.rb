require "csv"

class GithubIssue
  def initialize(issues)
    @issues = issues.map(&:with_indifferent_access)
  end

  def to_csv()
    CSV.generate do |csv|
      @issues.each do |issue|
        title = issue[:title].try(:slice, 0, 30)
        body = issue[:body].try(:slice, 0, 50)
        html_url = issue[:html_url]

        csv.add_row([title, body, html_url])
      end
    end
  end
end
