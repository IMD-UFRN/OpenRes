require 'spec_helper'

describe "object_resources/index" do
  before(:each) do
    assign(:object_resources, [
      stub_model(ObjectResource),
      stub_model(ObjectResource)
    ])
  end

  it "renders a list of object_resources" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
