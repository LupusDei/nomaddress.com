class AddValidUntil < ActiveRecord::Migration
  def up
    change_table :addresses do |t|
      t.datetime :valid_until
    end
  end

  def down
    remove_column :addresses, :valid_until
  end
end
