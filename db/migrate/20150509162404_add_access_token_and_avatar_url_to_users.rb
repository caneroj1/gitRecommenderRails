class AddAccessTokenAndAvatarUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :access_token, :string, default: ""
    add_column :users, :avatar_url, :string, default: ""
  end
end
