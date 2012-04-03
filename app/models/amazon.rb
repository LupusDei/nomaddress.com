class Amazon < ActiveRecord::Base
  belongs_to :address
  has_one :subscription, :as => :subscribable

  validates :email, :presence => true, :format => {:with => /^[a-zA-Z0-9]+@[a-zA-Z0-9]+.[a-zA-Z]+$/}
  validates :full_name, :presence => true
  validates :country, :presence => true
  validates :address, :presence => true
  validates :phone_number, :presence => true  

end