require 'spec_helper'

describe User do
  it "must have a valid email address" do
    valid_user = User.new(:first_name => "Justin", :last_name => "Martin", :email => "bob@loblaw.com")
    valid_user.should be_valid
  end
end
