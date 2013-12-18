require "spec_helper"

describe SectorsController do
  describe "routing" do

    it "routes to #index" do
      get("/sectors").should route_to("sectors#index")
    end

    it "routes to #new" do
      get("/sectors/new").should route_to("sectors#new")
    end

    it "routes to #show" do
      get("/sectors/1").should route_to("sectors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sectors/1/edit").should route_to("sectors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sectors").should route_to("sectors#create")
    end

    it "routes to #update" do
      put("/sectors/1").should route_to("sectors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sectors/1").should route_to("sectors#destroy", :id => "1")
    end

  end
end
