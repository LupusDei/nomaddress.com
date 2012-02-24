class ChangeAddressesTypeToCategory < ActiveRecord::Migration
  def up
    rename_column :addresses, :type, :category
  end

  def down
    rename_column :addresses, :category, :type
  end
end
