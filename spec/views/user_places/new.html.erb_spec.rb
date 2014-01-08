require 'spec_helper'

describe "user_places/new" do
  before(:each) do
    assign(:user_place, stub_model(UserPlace).as_new_record)
  end

  it "renders new user_place form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_places_path, "post" do
    end
  end
end
