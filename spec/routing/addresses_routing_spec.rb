require "spec_helper"

describe AddressesController do
  describe "routing" do

    it "routes to #index" do
      get("/addresses").should route_to("addresses#index")
    end

    it "routes to #new" do
      get("/addresses/new").should route_to("addresses#new")
    end

    it "routes to #show" do
      get("/addresses/1").should route_to("addresses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/addresses/1/edit").should route_to("addresses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/addresses").should route_to("addresses#create")
    end

    it "routes to #update" do
      put("/addresses/1").should route_to("addresses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/addresses/1").should route_to("addresses#destroy", :id => "1")
    end

  end
end
