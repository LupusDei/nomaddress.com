require File.expand_path("../../lib/update_runner.rb", File.dirname(__FILE__))

class UsersController < ApplicationController
 # before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]


  def run_update
    @notice = "Your address update has completed successfully!"
    if (!current_user.valid_password? params[:password])
      @notice = "The password you entered is invalid!"
    end

    if (notice != "The password you entered is invalid!")
      address = current_user.addresses.find(params[:address_id])
      dmv = address.subscriptions.find_by_subscribable_type("Dmv").try(:subscribable)
      amazon = address.subscriptions.find_by_subscribable_type("Amazon").try(:subscribable)
      if dmv
        UpdateRunner.run_dmv({:driver_license => dmv.driver_license, :ssn => dmv.ssn,
                            :county => dmv.county.upcase, :street => address.line1 + " " + address.line2,
                            :city => address.city, :zipCode => address.zip})
      end
      if amazon
        UpdateRunner.run_amazon({:email => amazon.email, :password => amazon.password, :full_name => amazon.full_name, :address1 => address.line1, :address2 => address.line2, :city => address.city, :state => address.state, :zip => address.zip, :country => amazon.country, :phone_number => "8471234567"})
      end
    end

    respond_to do | format |  
        format.js {render :layout => false}  
    end
    #redirect_to user_path(current_user), :notice => notice
  end

  def show
    if current_user.id != params[:id].to_i
      redirect_to user_path(current_user)
    else
      @user = User.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    end
  end

  def new
    @user = User.new
    @user.addresses << Address.find(params[:address_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    @user.addresses << Address.find(params[:address]["id"])
    respond_to do |format|
      if @user.save
        #mail = MailMan.confirmation(@user)
        #mail.deliver
        format.html { redirect_to @user, notice: 'Now you are good to go!' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    @user = User.find(params[:user_id] / 150)
    if @user.confirm!
      redirect_to @user, notice: "You are now activated!"
    else
      redirect_to :root
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
