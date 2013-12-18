require 'spec_helper'

describe "sectors/edit" do
  before(:each) do
    @sector = assign(:sector, stub_model(Sector))
  end

  it "renders the edit sector form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sector_path(@sector), "post" do
    end
  end
end
