require 'spec_helper'

describe "addresses/index.html.erb" do
  before(:each) do
    assign(:addresses, [
      stub_model(Address,
        :line1 => "Line1",
        :line2 => "Line2",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :type => "Type"
      ),
      stub_model(Address,
        :line1 => "Line1",
        :line2 => "Line2",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :type => "Type"
      )
    ])
  end

  it "renders a list of addresses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Line1".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Line2".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "State".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type".to_s, :count => 2
  end
end
