require "spec_helper"

describe PlandaysController do
  describe "routing" do

    it "routes to #index" do
      get("/plandays").should route_to("plandays#index")
    end

    it "routes to #new" do
      get("/plandays/new").should route_to("plandays#new")
    end

    it "routes to #show" do
      get("/plandays/1").should route_to("plandays#show", :id => "1")
    end

    it "routes to #edit" do
      get("/plandays/1/edit").should route_to("plandays#edit", :id => "1")
    end

    it "routes to #create" do
      post("/plandays").should route_to("plandays#create")
    end

    it "routes to #update" do
      put("/plandays/1").should route_to("plandays#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/plandays/1").should route_to("plandays#destroy", :id => "1")
    end

  end
end
