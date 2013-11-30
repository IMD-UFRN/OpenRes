require "spec_helper"

describe RoomTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/room_types").should route_to("room_types#index")
    end

    it "routes to #new" do
      get("/room_types/new").should route_to("room_types#new")
    end

    it "routes to #show" do
      get("/room_types/1").should route_to("room_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/room_types/1/edit").should route_to("room_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/room_types").should route_to("room_types#create")
    end

    it "routes to #update" do
      put("/room_types/1").should route_to("room_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/room_types/1").should route_to("room_types#destroy", :id => "1")
    end

  end
end
