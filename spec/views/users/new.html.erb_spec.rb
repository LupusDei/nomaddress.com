require 'spec_helper'

describe "users/new.html.erb" do
  before(:each) do
    assign(:user, stub_model(User,
      :first_name => "MyString",
      :last_name => "MyString",
      :gender => "MyString",
      :email => "MyString",
      :fb_uid => "MyString"
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path, :method => "post" do
      assert_select "input#user_first_name", :name => "user[first_name]"
      assert_select "input#user_last_name", :name => "user[last_name]"
      assert_select "input#user_gender", :name => "user[gender]"
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_fb_uid", :name => "user[fb_uid]"
    end
  end
end
