class Address < ActiveRecord::Base
  validates :line1 ,:presence => true 
  validates :state ,:presence => true 
  validates :city ,:presence => true 
  validates :zip ,:presence => true 
end
