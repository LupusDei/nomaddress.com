class ChangeSubscriptionToAPolymorphicSubscribableModel < ActiveRecord::Migration
  def up
    add_column :subscriptions, :subscribable_id, :integer
    add_column :subscriptions, :subscribable_type, :string
  end

  def down
    remove_column :subscriptions, :subscribable_id
    remove_column :subscriptions, :subscribable_type
  end
end
