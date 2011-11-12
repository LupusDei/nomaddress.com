class AddPasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :crypted_password, :string
  end
end
