require 'spec_helper'

describe "subscribers/index.html.erb" do
  before(:each) do
    assign(:subscribers, [
      stub_model(Subscriber,
        :name => "Name",
        :img_path => "Img Path",
        :type => "Type"
      ),
      stub_model(Subscriber,
        :name => "Name",
        :img_path => "Img Path",
        :type => "Type"
      )
    ])
  end

  it "renders a list of subscribers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Img Path".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type".to_s, :count => 2
  end
end
