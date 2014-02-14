require 'spec_helper'

describe "object_resources/edit" do
  before(:each) do
    @object_resource = assign(:object_resource, stub_model(ObjectResource))
  end

  it "renders the edit object_resource form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", object_resource_path(@object_resource), "post" do
    end
  end
end
