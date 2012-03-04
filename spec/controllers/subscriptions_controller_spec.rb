require 'spec_helper'

describe SubscriptionsController do
  def valid_attributes
    {:address_id => 1}
  end

  describe "GET show" do
    it "assigns the requested subscription as @subscription" do
      subscription = Subscription.create! valid_attributes
      get :show, :id => subscription.id.to_s
      assigns(:subscription).should eq(subscription)
    end
  end

  describe "GET new" do
    it "assigns a new subscription as @subscription" do
      get :new
      assigns(:subscription).should be_a_new(Subscription)
    end
  end

  describe "GET edit" do
    it "assigns the requested subscription as @subscription" do
      subscription = Subscription.create! valid_attributes
      get :edit, :id => subscription.id.to_s
      assigns(:subscription).should eq(subscription)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Subscription" do
        expect {
          post :create, :subscription => valid_attributes
        }.to change(Subscription, :count).by(1)
      end

      it "assigns a newly created subscription as @subscription" do
        post :create, :subscription => valid_attributes
        assigns(:subscription).should be_a(Subscription)
        assigns(:subscription).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved subscription as @subscription" do
        # Trigger the behavior that occurs when invalid params are submitted
        Subscription.any_instance.stub(:save).and_return(false)
        post :create, :subscription => {}
        assigns(:subscription).should be_a_new(Subscription)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested subscription" do
        subscription = Subscription.create! valid_attributes
        # Assuming there are no other subscriptions in the database, this
        # specifies that the Subscription created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Subscription.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => subscription.id, :subscription => {'these' => 'params'}
      end

      it "assigns the requested subscription as @subscription" do
        subscription = Subscription.create! valid_attributes
        put :update, :id => subscription.id, :subscription => valid_attributes
        assigns(:subscription).should eq(subscription)
      end

      it "redirects to the subscription" do
        subscription = Subscription.create! valid_attributes
        put :update, :id => subscription.id, :subscription => valid_attributes
        response.should redirect_to(subscription)
      end
    end

    describe "with invalid params" do
      it "assigns the subscription as @subscription" do
        subscription = Subscription.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Subscription.any_instance.stub(:save).and_return(false)
        put :update, :id => subscription.id.to_s, :subscription => {}
        assigns(:subscription).should eq(subscription)
      end

      it "re-renders the 'edit' template" do
        subscription = Subscription.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Subscription.any_instance.stub(:save).and_return(false)
        put :update, :id => subscription.id.to_s, :subscription => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested subscription" do
      subscription = Subscription.create! valid_attributes
      expect {
        delete :destroy, :id => subscription.id.to_s
      }.to change(Subscription, :count).by(-1)
    end

    it "redirects to the subscriptions list" do
      subscription = Subscription.create! valid_attributes
      delete :destroy, :id => subscription.id.to_s
      response.should redirect_to(subscriptions_url)
    end
  end

end
