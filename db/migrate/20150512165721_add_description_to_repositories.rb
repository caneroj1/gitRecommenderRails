class AddDescriptionToRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :description, :text
  end
end
