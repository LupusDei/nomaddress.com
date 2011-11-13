class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :name
      t.string :img_path
      t.string :type

      t.timestamps
    end
  end
end
