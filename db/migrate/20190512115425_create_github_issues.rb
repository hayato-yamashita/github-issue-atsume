class CreateGithubIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :github_issues do |t|
      t.references :github_repository, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false
      t.string :html_url, null: false

      t.timestamps
    end
  end
end
