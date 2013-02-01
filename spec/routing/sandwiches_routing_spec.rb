require "spec_helper"

describe SandwichesController do
  describe "routing" do

    it "routes to #index" do
      get("/sandwiches").should route_to("sandwiches#index")
    end

    it "routes to #new" do
      get("/sandwiches/new").should route_to("sandwiches#new")
    end

    it "routes to #show" do
      get("/sandwiches/1").should route_to("sandwiches#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sandwiches/1/edit").should route_to("sandwiches#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sandwiches").should route_to("sandwiches#create")
    end

    it "routes to #update" do
      put("/sandwiches/1").should route_to("sandwiches#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sandwiches/1").should route_to("sandwiches#destroy", :id => "1")
    end

  end
end
