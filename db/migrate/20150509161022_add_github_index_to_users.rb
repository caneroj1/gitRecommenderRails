class AddGithubIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :github_id
  end
end
