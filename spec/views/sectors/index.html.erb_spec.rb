require 'spec_helper'

describe "sectors/index" do
  before(:each) do
    assign(:sectors, [
      stub_model(Sector),
      stub_model(Sector)
    ])
  end

  it "renders a list of sectors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
