require 'spec_helper'

describe "subscriptions/edit.html.erb" do
  before(:each) do
    @subscription = assign(:subscription, stub_model(Subscription,
      :subscriber_id => 1,
      :address_id => 1
    ))
  end

  it "renders the edit subscription form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => subscriptions_path(@subscription), :method => "post" do
      assert_select "input#subscription_subscriber_id", :name => "subscription[subscriber_id]"
      assert_select "input#subscription_address_id", :name => "subscription[address_id]"
    end
  end
end
