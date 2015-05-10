class AddLanguageBreakdownToUsers < ActiveRecord::Migration
  def change
    add_column :users, :language_breakdown, :text
  end
end
