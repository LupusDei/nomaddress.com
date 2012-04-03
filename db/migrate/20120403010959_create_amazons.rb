class CreateAmazons < ActiveRecord::Migration
  def change
    create_table :amazons do |t|
      t.string :email
      t.string :full_name
      t.string :country
      t.string :phone_number
      t.references :address

      t.timestamps
    end
    add_index :amazons, :address_id
  end
end