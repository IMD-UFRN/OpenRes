# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "class_monitors/new" do
  before(:each) do
    assign(:class_monitor, stub_model(ClassMonitor).as_new_record)
  end

  it "renders new class_monitor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", class_monitors_path, "post" do
    end
  end
end
