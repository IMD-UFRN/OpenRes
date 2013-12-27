# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "sectors/show" do
  before(:each) do
    @sector = assign(:sector, stub_model(Sector))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
