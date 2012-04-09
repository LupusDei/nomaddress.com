class CreateEbays < ActiveRecord::Migration
  def change
    create_table :ebays do |t|
      t.string :first_name
      t.string :last_name
      t.string :country
      t.string :phone_number
      t.references :address

      t.timestamps
    end
    add_index :ebays, :address_id
  end
end
