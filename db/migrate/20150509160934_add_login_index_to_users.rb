class AddLoginIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :login
  end
end
