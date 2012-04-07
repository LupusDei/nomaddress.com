class Ebay < ActiveRecord::Base
  belongs_to :address
  has_one :subscription, :as => :subscribable

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :country, :presence => true
  validates :phone_number, :presence => true
  validates :address, :presence => true

end
