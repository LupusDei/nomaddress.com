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
    @subscribable = Dmv.new(:address_id => params[:address_id])

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
      @subscription = Subscription.create(:address_id => params[:dmv][:address_id])
      @dmv = Dmv.new(params[:dmv])
      @dmv.subscription = @subscription
      @dmv.save
      redirect_to @subscription
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
