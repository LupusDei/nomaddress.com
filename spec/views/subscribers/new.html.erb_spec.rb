require 'spec_helper'

describe "subscribers/new.html.erb" do
  before(:each) do
    assign(:subscriber, stub_model(Subscriber,
      :name => "MyString",
      :img_path => "MyString",
      :type => ""
    ).as_new_record)
  end

  it "renders new subscriber form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => subscribers_path, :method => "post" do
      assert_select "input#subscriber_name", :name => "subscriber[name]"
      assert_select "input#subscriber_img_path", :name => "subscriber[img_path]"
      assert_select "input#subscriber_type", :name => "subscriber[type]"
    end
  end
end
