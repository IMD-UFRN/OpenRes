# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "class_monitors/show" do
  before(:each) do
    @class_monitor = assign(:class_monitor, stub_model(ClassMonitor))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
