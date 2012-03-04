class Dmv < ActiveRecord::Base
  belongs_to :address

  validates :driver_license, :presence => true, :format => {:with => /^[a-zA-Z0-9]+$/}
  validates :ssn, :presence => true,  :format => {:with => /^\d{4}$/}
  validates :county, :presence => true, :format => {:with => /^[a-zA-Z]+$/}
  validates :address, :presence => true
  
end
