class CreateDmvs < ActiveRecord::Migration
  def change
    create_table :dmvs do |t|
      t.string :driver_license
      t.integer :ssn
      t.references :address
      t.string :county

      t.timestamps
    end
    add_index :dmvs, :address_id
  end
end
