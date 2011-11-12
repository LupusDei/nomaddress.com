class AddSessionFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_salt, :string
    add_column :users, :persistence_token, :string
    add_column :users, :last_login_at, :datetime
    add_column :users, :last_request_at, :datetime
    add_column :users, :current_login_ip, :string
    add_column :users, :last_login_ip, :string
    add_column :users, :login_count, :integer, :null => false, :default => 0
  end
end
