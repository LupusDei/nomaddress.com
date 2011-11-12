require 'spec_helper'

describe "addresses/show.html.erb" do
  before(:each) do
    @address = assign(:address, stub_model(Address,
      :line1 => "Line1",
      :line2 => "Line2",
      :city => "City",
      :state => "State",
      :zip => "Zip",
      :type => "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Line1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Line2/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/City/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/State/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Zip/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Type/)
  end
end
