require 'spec_helper'

describe "sectors/new" do
  before(:each) do
    assign(:sector, stub_model(Sector).as_new_record)
  end

  it "renders new sector form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sectors_path, "post" do
    end
  end
end
