class ChangeColumn2 < ActiveRecord::Migration
  def up
    change_column :dmvs, :ssn, :string
  end

  def down
  end
end
