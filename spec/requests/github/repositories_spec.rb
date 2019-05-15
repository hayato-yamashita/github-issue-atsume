require 'rails_helper'

RSpec.describe "Github::Repositories", type: :request do
  describe "GET #index" do
    subject { get github_repositories_path }

    it { is_expected.to eq(200) }
  end

  describe "GET #show" do
    context "対象のレコードが存在する場合" do
      subject { get github_repository_path(repository) }

      let!(:repository) { create(:github_repository) }

      it { is_expected.to eq(200) }
    end

    context "対象のレコードが存在しない場合" do
      subject { get github_repository_path(id: 0) }

      it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe "GET #new" do
    subject { get new_github_repository_path }

    it { is_expected.to eq(200) }
  end

  describe "POST #create" do
    context "パラメータが正当な場合" do
      subject { post github_repositories_path(params: { github_repository: repository_params }) }

      let(:repository_params) { attributes_for(:github_repository) }

      it { is_expected.to redirect_to(root_url) }
      it { expect { subject }.to change { Github::Repository.count }.by(1) }

      it "notice にメッセージが出ていること" do
        subject
        expect(flash[:notice]).to be_present
      end
  end
    
    context "パラメータが不当な場合" do
      subject { post github_repositories_path(params: { github_repository: repository_params }) }

      let(:repository_params) { attributes_for(:github_repository, :invalid) }

      it { is_expected.to eq(200) }
      it { expect { subject }.not_to change { Github::Repository.count } }

      it "notice にメッセージが出ていないこと" do
        subject
        expect(flash[:notice]).to be_nil
      end
    end
  end

  describe "DELETE #destroy" do
    context "対象のレコードが存在する場合" do
      subject { delete github_repository_path(repository) }

      let!(:repository) { create(:github_repository) }

      context "削除に成功した場合" do
        it { is_expected.to redirect_to(root_url) }
        it { expect { subject }.to change { Github::Repository.count }.by(-1) }

        it "notice にメッセージが出ていること" do
          subject
          expect(flash[:notice]).to be_present
          expect(flash[:alert]).to be_nil
        end
      end

      context "削除に失敗した場合" do
        before do
          allow(Github::Repository).to receive(:find).with(repository.id.to_s).and_return(repository)
          allow(repository).to receive(:destroy).and_return(false)
          allow(repository).to receive_message_chain(:errors, :full_messages).and_return([ "hoge" ])
        end

        it { is_expected.to redirect_to(root_url) }

        it "alert にメッセージが出ていること" do
          subject
          expect(flash[:notice]).to be_nil
          expect(flash[:alert]).to be_present
        end
      end
    end

    context "対象のレコードが存在しない場合" do
      subject { delete github_repository_path(id: 0) }

      it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe "POST #fetch" do
    context "対象のレコードが存在する場合" do
      subject { post fetch_github_repository_path(repository) }

      let!(:repository) { create(:github_repository) }

      context "取得に成功した場合" do
        before do
          allow(Github::Repository).to receive(:find).with(repository.id.to_s).and_return(repository)
          allow(repository).to receive(:refresh_issues).and_return(true)
        end

        it { is_expected.to redirect_to(repository) }

        it "notice にメッセージが出ていること" do
          subject
          expect(flash[:notice]).to be_present
          expect(flash[:alert]).to be_nil
        end
      end

      context "取得に失敗した場合" do
        before do
          allow(Github::Repository).to receive(:find).with(repository.id.to_s).and_return(repository)
          allow(repository).to receive(:refresh_issues).and_return(false)
        end

        it { is_expected.to redirect_to(repository) }

        it "alert にメッセージが出ていること" do
          subject
          expect(flash[:notice]).to be_nil
          expect(flash[:alert]).to be_present
        end
      end
    end

    context "対象のレコードが存在しない場合" do
      subject { post fetch_github_repository_path(id: 0) }

      it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end
end
