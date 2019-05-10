require "rails_helper"
require "csv"

RSpec.describe GithubIssue, type: :model do
  describe "#to_csv" do
    let(:csv) { GithubIssue.new(issues).to_csv }

    context "複数行の場合" do
      let(:issues) do
        [
          { title: "123", body: "456", html_url: "http://exapmle.com/" },
          { title: "abc", body: "def", html_url: "https://exapmle.com/" },
        ]
      end

      it "すべての行が出力されること" do
        expect(csv).to eq "123,456,http://exapmle.com/\nabc,def,https://exapmle.com/\n"
      end
    end

    context "出力対象以外のカラムが存在する場合" do
      let(:issues) do
        [
          { title: "123", body: "456", html_url: "http://exapmle.com/", other: "hoge" }
        ]
      end

      it "title, body, html_url だけ出力されること" do
        expect(csv).to eq "123,456,http://exapmle.com/\n"
      end
    end

    context "カラムの順序がおかしい場合" do
      let(:issues) do
        [
          { body: "456", html_url: "http://exapmle.com/", title: "123" }
        ]
      end

      it "title, body, html_url の順序で出力されること" do
        expect(csv).to eq "123,456,http://exapmle.com/\n"
      end
    end

    context "文字数が規定値を超える場合（シングルバイト）" do
      let(:issues) do
        [
          {
            title: "1234567890" * 10,
            body: "1234567890" * 10,
            html_url: "1234567890" * 10,
          }
        ]
      end

      it "title は先頭30文字で切られること" do
        title = CSV.parse_line(csv)[0]
        expect(title.length).to eq 30
      end

      it "body は先頭50文字で切られること" do
        body = CSV.parse_line(csv)[1]
        expect(body.length).to eq 50
      end

      it "html_url はそのままであること" do
        html_url = CSV.parse_line(csv)[2]
        expect(html_url.length).to eq 100
      end
    end

    context "文字数が規定値を超える場合（マルチバイト）" do
      let(:issues) do
        [
          {
            title: "１２３４５６７８９０" * 10,
            body: "１２３４５６７８９０" * 10,
            html_url: "１２３４５６７８９０" * 10,
          }
        ]
      end

      it "title は先頭30文字で切られること" do
        title = CSV.parse_line(csv)[0]
        expect(title.length).to eq 30
      end

      it "body は先頭50文字で切られること" do
        body = CSV.parse_line(csv)[1]
        expect(body.length).to eq 50
      end

      it "html_url はそのままであること" do
        html_url = CSV.parse_line(csv)[2]
        expect(html_url.length).to eq 100
      end
    end
  end
end
