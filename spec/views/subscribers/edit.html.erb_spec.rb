require 'spec_helper'

describe "subscribers/edit.html.erb" do
  before(:each) do
    @subscriber = assign(:subscriber, stub_model(Subscriber,
      :name => "MyString",
      :img_path => "MyString",
      :type => ""
    ))
  end

  it "renders the edit subscriber form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => subscribers_path(@subscriber), :method => "post" do
      assert_select "input#subscriber_name", :name => "subscriber[name]"
      assert_select "input#subscriber_img_path", :name => "subscriber[img_path]"
      assert_select "input#subscriber_type", :name => "subscriber[type]"
    end
  end
end
