class Subscription < ActiveRecord::Base
  belongs_to :address
  belongs_to :subscriber
  belongs_to :subscribable, :polymorphic => true
end
