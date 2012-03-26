require 'spec_helper'
require File.expand_path("../../lib/update_runner.rb", File.dirname(__FILE__))

describe UsersController do

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {:first_name => "Test", :last_name => "User", :email => "user@user.user", :password => "password", :password_confirmation => "password"}
  end
  
  def ignore_login_required
    controller.stub!(:require_user).and_return(true)
    controller.stub!(:current_user).and_return(@user)
  end
  
  before do 
    @user = User.create valid_attributes
  end

  describe "Update Scripts" do
    describe "Dmv script" do
      before do
        @address = Address.new(:line1 => "Address", :city => "somewhere", :zip => "123456", :state => "somestate")
        @valid_dmv = Dmv.new(:driver_license => "s123456", :ssn => "1234", :county => "Champaign")
        @user.addresses << @address
        @user.save
        @valid_dmv.address = @address
        @valid_dmv.save
        @address.subscriptions.create(:subscribable => @valid_dmv)

        @address.subscriptions.first.subscribable.should == @valid_dmv
      end

      it "will kick off the dmv update script" do
        ignore_login_required

        UpdateRunner.should_receive(:run_dmv).with({:driver_license => @valid_dmv.driver_license, :ssn => @valid_dmv.ssn,
                                                    :county => @valid_dmv.county.upcase, :street => @address.line1 + " " + @address.line2,
                                                    :city => @address.city, :zipCode => @address.zip})

        get :run_update, :address_id => @address.id
      end

      it "redirects to the user page with a success message" do
        ignore_login_required
        get :run_update, :address_id => @address.id
        flash[:notice].should == "Your address update has completed successfully!"
      end
    end
  end

  describe "GET show" do

    it "will not authorize non-loggedin users to view their show page" do
      get :show, :id => @user.id.to_s

      response.should redirect_to(login_path)
    end
    
    it "assigns the requested user as @user" do
      ignore_login_required
      get :show, :id => @user.id.to_s
      response.should be_success
      assigns(:user).should eq(@user)
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      ignore_login_required
      addr = Address.new
      Address.should_receive(:find).and_return(addr)
      get :new
      assigns(:user).should be_a_new(User)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      ignore_login_required
      get :edit, :id => @user.id.to_s
      assigns(:user).should eq(@user)
    end
  end

  describe "POST create" do
    before do 
      @address = Address.new(:line1 => "blah", :zip => "12345", :city => "Blah", :state => "IL", :type => "Home")
      @address.should be_valid
      @address.save
    end

    describe "with valid params" do
      before do 
        User.delete_all
      end
      def post_valid_user
        post :create, :user => valid_attributes, :address => {"id" => @address.id}
      end

      it "creates a new User" do
        expect {
          post_valid_user
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post_valid_user
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the created user" do
        post_valid_user
        response.should redirect_to(User.last)
      end

      it "should login the created user" do
        post_valid_user
        user = User.last

        user.should be_logged_in
      end
    end

    describe "with invalid params" do
      def post_invalid_user
        post :create, :user => {}, :address => {"id" => @address.id}
      end

      it "assigns a newly created but unsaved user as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post_invalid_user
        assigns(:user).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post_invalid_user
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        User.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        ignore_login_required
        put :update, :id => @user.id, :user => {'these' => 'params'}
      end

      it "assigns the requested user as @user" do
        ignore_login_required
        put :update, :id => @user.id, :user => valid_attributes
        assigns(:user).should eq(@user)
      end

      it "redirects to the user" do
        ignore_login_required
        put :update, :id => @user.id, :user => valid_attributes
        response.should redirect_to(@user)
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        ignore_login_required
        put :update, :id => @user.id.to_s, :user => {}
        assigns(:user).should eq(@user)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        ignore_login_required
        put :update, :id => @user.id.to_s, :user => {}
        response.should render_template("edit")
      end
    end
  end

end
