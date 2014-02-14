# -*- encoding : utf-8 -*-
require "spec_helper"

describe ObjectResourcesController do
  describe "routing" do

    it "routes to #index" do
      get("/object_resources").should route_to("object_resources#index")
    end

    it "routes to #new" do
      get("/object_resources/new").should route_to("object_resources#new")
    end

    it "routes to #show" do
      get("/object_resources/1").should route_to("object_resources#show", :id => "1")
    end

    it "routes to #edit" do
      get("/object_resources/1/edit").should route_to("object_resources#edit", :id => "1")
    end

    it "routes to #create" do
      post("/object_resources").should route_to("object_resources#create")
    end

    it "routes to #update" do
      put("/object_resources/1").should route_to("object_resources#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/object_resources/1").should route_to("object_resources#destroy", :id => "1")
    end

  end
end
