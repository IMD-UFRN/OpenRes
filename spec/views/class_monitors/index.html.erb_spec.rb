# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "class_monitors/index" do
  before(:each) do
    assign(:class_monitors, [
      stub_model(ClassMonitor),
      stub_model(ClassMonitor)
    ])
  end

  it "renders a list of class_monitors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
