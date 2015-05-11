class AddInfoToRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :readme_text, :text
  end
end
