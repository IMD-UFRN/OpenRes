require "spec_helper"

describe ClassMonitorsController do
  describe "routing" do

    it "routes to #index" do
      get("/class_monitors").should route_to("class_monitors#index")
    end

    it "routes to #new" do
      get("/class_monitors/new").should route_to("class_monitors#new")
    end

    it "routes to #show" do
      get("/class_monitors/1").should route_to("class_monitors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/class_monitors/1/edit").should route_to("class_monitors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/class_monitors").should route_to("class_monitors#create")
    end

    it "routes to #update" do
      put("/class_monitors/1").should route_to("class_monitors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/class_monitors/1").should route_to("class_monitors#destroy", :id => "1")
    end

  end
end
