class AddStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :string, :default => "pending"
  end
end
