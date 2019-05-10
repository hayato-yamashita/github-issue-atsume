require "csv"

class GithubIssue
  def initialize(issues)
    @issues = issues
  end

  def to_csv()
    CSV.generate do |csv|
      @issues.each do |issue|
        title = issue["title"].slice(0, 30)
        body = issue["body"].slice(0, 50)
        html_url = issue["html_url"]

        csv.add_row([title, body, html_url])
      end
    end
  end
end
