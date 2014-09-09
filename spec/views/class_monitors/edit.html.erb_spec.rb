require 'spec_helper'

describe "class_monitors/edit" do
  before(:each) do
    @class_monitor = assign(:class_monitor, stub_model(ClassMonitor))
  end

  it "renders the edit class_monitor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", class_monitor_path(@class_monitor), "post" do
    end
  end
end
