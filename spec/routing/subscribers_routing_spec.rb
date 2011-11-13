require "spec_helper"

describe SubscribersController do
  describe "routing" do

    it "routes to #index" do
      get("/subscribers").should route_to("subscribers#index")
    end

    it "routes to #new" do
      get("/subscribers/new").should route_to("subscribers#new")
    end

    it "routes to #show" do
      get("/subscribers/1").should route_to("subscribers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/subscribers/1/edit").should route_to("subscribers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/subscribers").should route_to("subscribers#create")
    end

    it "routes to #update" do
      put("/subscribers/1").should route_to("subscribers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/subscribers/1").should route_to("subscribers#destroy", :id => "1")
    end

  end
end
