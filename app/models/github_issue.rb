require "csv"

class GithubIssue
  def initialize(issues)
    @issues = issues.map(&:with_indifferent_access)
  end

  def to_csv
    CSV.generate do |csv|
      @issues.each do |issue|
        hash = convert_hash(issue)
        csv.add_row([hash[:title], hash[:body], hash[:html_url]])
      end
    end
  end

  def to_hash
    @issues.map do |issue|
      convert_hash(issue)
    end
  end

  private

    def convert_hash(issue)
      {
        title: issue[:title].try(:slice, 0, 30),
        body: issue[:body].try(:slice, 0, 50),
        html_url: issue[:html_url],
      }
    end
end
