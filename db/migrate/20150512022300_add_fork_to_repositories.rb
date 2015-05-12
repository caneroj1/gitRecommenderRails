class AddForkToRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :is_forked, :boolean, default: false
  end
end
