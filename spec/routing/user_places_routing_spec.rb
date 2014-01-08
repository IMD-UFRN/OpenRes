require "spec_helper"

describe UserPlacesController do
  describe "routing" do

    it "routes to #index" do
      get("/user_places").should route_to("user_places#index")
    end

    it "routes to #new" do
      get("/user_places/new").should route_to("user_places#new")
    end

    it "routes to #show" do
      get("/user_places/1").should route_to("user_places#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_places/1/edit").should route_to("user_places#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_places").should route_to("user_places#create")
    end

    it "routes to #update" do
      put("/user_places/1").should route_to("user_places#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_places/1").should route_to("user_places#destroy", :id => "1")
    end

  end
end
