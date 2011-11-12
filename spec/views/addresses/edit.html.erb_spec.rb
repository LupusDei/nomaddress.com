require 'spec_helper'

describe "addresses/edit.html.erb" do
  before(:each) do
    @address = assign(:address, stub_model(Address,
      :line1 => "MyString",
      :line2 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "MyString",
      :type => ""
    ))
  end

  it "renders the edit address form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => addresses_path(@address), :method => "post" do
      assert_select "input#address_line1", :name => "address[line1]"
      assert_select "input#address_line2", :name => "address[line2]"
      assert_select "input#address_city", :name => "address[city]"
      assert_select "input#address_state", :name => "address[state]"
      assert_select "input#address_zip", :name => "address[zip]"
      assert_select "input#address_type", :name => "address[type]"
    end
  end
end
