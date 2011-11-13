require 'spec_helper'

describe "subscriptions/show.html.erb" do
  before(:each) do
    @subscription = assign(:subscription, stub_model(Subscription,
      :subscriber_id => 1,
      :address_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
