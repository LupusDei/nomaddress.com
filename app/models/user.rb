class User < ActiveRecord::Base
  acts_as_authentic
  has_many :addresses
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}

  def confirm!
    self.update_attributes(:status => "active")
  end

end
