class SubscriptionsController < ApplicationController
  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/new
  # GET /subscriptions/new.json
  def new
    @subscription = Subscription.new(:address_id => params[:address_id])
    @dmv_subscribable = Dmv.find_or_initialize_by_address_id(params[:address_id])
    @amazon_subscribable = Amazon.find_or_initialize_by_address_id(params[:address_id])
    if params[:firsttime]
      render :firsttime
    else
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @subscription }
      end
    end
  end

  # GET /subscriptions/1/edit
  def edit
    @subscription = Subscription.find(params[:id])
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    if params[:firsttime]
      @subscription = Subscription.new(params[:subscription])

      @subscription.save
      respond_to do |format|
        format.html { redirect_to :controller => 'users', :action => 'new', :address_id => @subscription.address_id.to_s}
      end
    else
      if params[:dmv]
        @subscription = Subscription.create(:address_id => params[:dmv][:address_id])
        @dmv = Dmv.find_or_initialize_by_address_id(params[:dmv][:address_id])
        @dmv.update_attributes(params[:dmv])
        @dmv.subscription = @subscription
        @dmv.save
      end
      if params[:amazon]
        @subscription = Subscription.create(:address_id => params[:amazon][:address_id])
        @amazon = Amazon.find_or_initialize_by_address_id(params[:amazon][:address_id])
        @amazon.update_attributes(params[:amazon])
        @amazon.subscription = @subscription
        @amazon.save
      end
        
      redirect_to user_path(current_user)
    end
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.json
  def update
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to subscriptions_url }
      format.json { head :ok }
    end
  end
end
