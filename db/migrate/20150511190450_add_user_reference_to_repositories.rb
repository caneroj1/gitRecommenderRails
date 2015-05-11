class AddUserReferenceToRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :user_id, :integer
    add_column :repositories, :belongs_to_on_github, :integer
  end
end
