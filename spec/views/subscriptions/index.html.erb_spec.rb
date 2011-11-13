require 'spec_helper'

describe "subscriptions/index.html.erb" do
  before(:each) do
    assign(:subscriptions, [
      stub_model(Subscription,
        :subscriber_id => 1,
        :address_id => 1
      ),
      stub_model(Subscription,
        :subscriber_id => 1,
        :address_id => 1
      )
    ])
  end

  it "renders a list of subscriptions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
