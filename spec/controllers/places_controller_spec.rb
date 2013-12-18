require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PlacesController do

  # This should return the minimal set of attributes required to create a valid
  # Place. As you add validations to Place, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PlacesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all places as @places" do
      place = Place.create! valid_attributes
      get :index, {}, valid_session
      assigns(:places).should eq([place])
    end
  end

  describe "GET show" do
    it "assigns the requested place as @place" do
      place = Place.create! valid_attributes
      get :show, {:id => place.to_param}, valid_session
      assigns(:place).should eq(place)
    end
  end

  describe "GET new" do
    it "assigns a new place as @place" do
      get :new, {}, valid_session
      assigns(:place).should be_a_new(Place)
    end
  end

  describe "GET edit" do
    it "assigns the requested place as @place" do
      place = Place.create! valid_attributes
      get :edit, {:id => place.to_param}, valid_session
      assigns(:place).should eq(place)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Place" do
        expect {
          post :create, {:place => valid_attributes}, valid_session
        }.to change(Place, :count).by(1)
      end

      it "assigns a newly created place as @place" do
        post :create, {:place => valid_attributes}, valid_session
        assigns(:place).should be_a(Place)
        assigns(:place).should be_persisted
      end

      it "redirects to the created place" do
        post :create, {:place => valid_attributes}, valid_session
        response.should redirect_to(Place.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved place as @place" do
        # Trigger the behavior that occurs when invalid params are submitted
        Place.any_instance.stub(:save).and_return(false)
        post :create, {:place => {  }}, valid_session
        assigns(:place).should be_a_new(Place)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Place.any_instance.stub(:save).and_return(false)
        post :create, {:place => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested place" do
        place = Place.create! valid_attributes
        # Assuming there are no other places in the database, this
        # specifies that the Place created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Place.any_instance.should_receive(:update).with({ "these" => "params" })
        put :update, {:id => place.to_param, :place => { "these" => "params" }}, valid_session
      end

      it "assigns the requested place as @place" do
        place = Place.create! valid_attributes
        put :update, {:id => place.to_param, :place => valid_attributes}, valid_session
        assigns(:place).should eq(place)
      end

      it "redirects to the place" do
        place = Place.create! valid_attributes
        put :update, {:id => place.to_param, :place => valid_attributes}, valid_session
        response.should redirect_to(place)
      end
    end

    describe "with invalid params" do
      it "assigns the place as @place" do
        place = Place.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Place.any_instance.stub(:save).and_return(false)
        put :update, {:id => place.to_param, :place => {  }}, valid_session
        assigns(:place).should eq(place)
      end

      it "re-renders the 'edit' template" do
        place = Place.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Place.any_instance.stub(:save).and_return(false)
        put :update, {:id => place.to_param, :place => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested place" do
      place = Place.create! valid_attributes
      expect {
        delete :destroy, {:id => place.to_param}, valid_session
      }.to change(Place, :count).by(-1)
    end

    it "redirects to the places list" do
      place = Place.create! valid_attributes
      delete :destroy, {:id => place.to_param}, valid_session
      response.should redirect_to(places_url)
    end
  end

end
