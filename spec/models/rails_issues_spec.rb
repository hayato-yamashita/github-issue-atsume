require "rails_helper"

RSpec.describe RailsIssues do
  describe "#puts_csv" do
    context "レスポンスの成否によって出力方法を変える" do
      let(:response) do
        stub_connection = Faraday.new do |connection|
          connection.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
            stub.get("/test") { [status, {}, {}] }
          end
        end

        stub_connection.get("/test")
      end

      before do
        allow(Api::Github).to receive(:repos_issues).and_return(response)
        allow(RailsIssues).to receive(:puts_success)
        allow(RailsIssues).to receive(:puts_error)
      end

      context "成功の場合" do
        let(:status) { 200 }

        it "puts_success が呼ばれること" do
          RailsIssues.puts_csv(page: 123)
          expect(RailsIssues).to have_received(:puts_success).once
          expect(RailsIssues).not_to have_received(:puts_error)
        end
      end

      context "失敗の場合" do
        let(:status) { 403 }

        it "puts_error が呼ばれること" do
          RailsIssues.puts_csv(page: 123)
          expect(RailsIssues).not_to have_received(:puts_success)
          expect(RailsIssues).to have_received(:puts_error).once
        end
      end
    end
  end
end
