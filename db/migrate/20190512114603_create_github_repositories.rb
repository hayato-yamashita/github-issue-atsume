class CreateGithubRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :github_repositories do |t|
      t.string :owner, null: false
      t.string :repo, null: false

      t.timestamps
    end

    add_index :github_repositories, [:owner, :repo], unique: true
  end
end
