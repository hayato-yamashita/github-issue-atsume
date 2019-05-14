require 'rails_helper'

RSpec.describe Github::Repository, type: :model do
  describe "#display_name" do
    subject { repository.display_name }

    let(:repository) { create(:github_repository) }

    it { is_expected.to eq "MyOwner / MyRepo" }
  end

  describe "#html_url" do
    subject { repository.html_url }

    let(:repository) { create(:github_repository) }

    it { is_expected.to eq "https://github.com/MyOwner/MyRepo/" }
  end

  describe "#refresh_issues" do
    subject { repository.refresh_issues }

    let(:repository) { create(:github_repository) }

    context "取得に成功した場合" do
      before do
        allow(Api::Github).to receive_message_chain(:repos_issues, :success?).and_return(true)
        allow(Api::Github).to receive_message_chain(:repos_issues, :env, :body).and_return("{}")
        allow(GithubIssue).to receive_message_chain(:new, :to_hash).and_return([
          { title: "title_01", body: "body_01", html_url: "url_01" },
          { title: "title_02", body: "body_02", html_url: "url_02" },
          { title: "title_03", body: "body_03", html_url: "url_03" },
        ])

        create_list(:github_issue, 5, repository: repository)
      end
  
      it { is_expected.to be true }

      it "issues が取得された内容で更新されていること" do
        subject
        repository.reload

        expect(repository.issues.count).to eq 3
        expect(repository.issues.map(&:title)).to contain_exactly("title_01", "title_02", "title_03")
      end
    end

    context "取得に失敗した場合（レスポンスが成功でない）" do
      before do
        allow(Api::Github).to receive_message_chain(:repos_issues, :success?).and_return(false)
      end
  
      it { is_expected.to be false }
    end

    context "取得に失敗した場合（例外が発生）" do
      before do
        allow(Api::Github).to receive_message_chain(:repos_issues, :success?).and_return(true)
        allow(Api::Github).to receive_message_chain(:repos_issues, :env, :body).and_return("{}")
        allow(GithubIssue).to receive_message_chain(:new, :to_hash).and_return([])
        allow(repository.issues).to receive(:create!).and_raise("test error")
      end
  
      it { is_expected.to be false }
    end
  end
end
