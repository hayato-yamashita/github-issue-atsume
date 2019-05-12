require 'rails_helper'

RSpec.describe "Github::Repositories", type: :request do
  describe "GET /github/repositories" do
    it "works! (now write some real specs)" do
      get github_repositories_path
      expect(response).to have_http_status(200)
    end
  end
end
