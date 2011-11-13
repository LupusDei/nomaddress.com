class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :subscriber_id
      t.integer :address_id

      t.timestamps
    end
  end
end
