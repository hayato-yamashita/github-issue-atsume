require "rails_helper"

RSpec.describe Api::Github do
  describe "#repos_issues" do
    let(:response) { Api::Github.repos_issues(owner: "hayato-yamashita", repo: "github-issue-atsume", page: 123) }

    before do
      stub_request(:get, "https://api.github.com/repos/hayato-yamashita/github-issue-atsume/issues").
      with(query: {page: 123}).
      to_return(status: 200)
    end

    it "引数に応じた API アクセスができること" do
      expect(response.status).to eq 200
    end
  end
end
