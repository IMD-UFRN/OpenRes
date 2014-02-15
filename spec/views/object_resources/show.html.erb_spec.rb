# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "object_resources/show" do
  before(:each) do
    @object_resource = assign(:object_resource, stub_model(ObjectResource))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
