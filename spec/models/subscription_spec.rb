require 'spec_helper'

describe Subscription do

  it "has a subscribable" do
    sub = Subscription.new
    sub.subscribable.should be_nil
  end

end
