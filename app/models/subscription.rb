class Subscription < ActiveRecord::Base
  belongs_to :address
  belongs_to :subscriber
end
