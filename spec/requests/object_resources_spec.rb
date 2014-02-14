require 'spec_helper'

describe "ObjectResources" do
  describe "GET /object_resources" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get object_resources_path
      response.status.should be(200)
    end
  end
end
