class Dmv < ActiveRecord::Base
  belongs_to :address

  validates :driver_license, :presence => true
  validates :ssn, :presence => true
  validates :county, :presence => true, :format => {:with => /^[a-zA-Z]+$/}
  validates :address, :presence => true
  
end
