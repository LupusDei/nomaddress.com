class AddPasswordToAmazon < ActiveRecord::Migration
  def change
    add_column :amazons, :password, :string
  end
end
