# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "object_resources/new" do
  before(:each) do
    assign(:object_resource, stub_model(ObjectResource).as_new_record)
  end

  it "renders new object_resource form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", object_resources_path, "post" do
    end
  end
end
