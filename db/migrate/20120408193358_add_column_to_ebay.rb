class AddColumnToEbay < ActiveRecord::Migration
  def change
	add_column :ebays, :username, :string
  end
end
