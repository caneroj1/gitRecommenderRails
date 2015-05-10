class AddKeywordsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :keyword_one, :string
    add_column :users, :keyword_two, :string
    add_column :users, :keyword_three, :string
    add_column :users, :keyword_four, :string
    add_column :users, :keyword_five, :string
  end
end
