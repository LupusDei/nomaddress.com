class Address < ActiveRecord::Base
  belongs_to :user
  validates :line1 ,:presence => true 
  validates :state ,:presence => true 
  validates :city ,:presence => true 
  validates :zip ,:presence => true 
end
