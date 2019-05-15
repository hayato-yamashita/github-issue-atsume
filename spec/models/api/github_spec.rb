require "rails_helper"

RSpec.describe Api::Github do
  describe "#repos_issues" do
    context "引数を省略しない場合" do
      let(:response) do
        Api::Github.repos_issues(
          owner: "hayato-yamashita",
          repo: "github-issue-atsume",
          page: 123,
          per_page: 456,
        )
      end

      before do
        stub_request(:get, "https://api.github.com/repos/hayato-yamashita/github-issue-atsume/issues").
        with(query: { page: 123, per_page: 456 }).
        to_return(status: 200)
      end

      it "引数に応じた API アクセスができること" do
        expect(response.status).to eq 200
      end
    end

    context "引数を省略する場合" do
      let(:response) do
        Api::Github.repos_issues(
          owner: "hayato-yamashita",
          repo: "github-issue-atsume",
          page: 123,
        )
      end

      before do
        stub_request(:get, "https://api.github.com/repos/hayato-yamashita/github-issue-atsume/issues").
        with(query: { page: 123 }).
        to_return(status: 200)
      end

      it "引数に応じた API アクセスができること" do
        expect(response.status).to eq 200
      end
    end
  end
end
