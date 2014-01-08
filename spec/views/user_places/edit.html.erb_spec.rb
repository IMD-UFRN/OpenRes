require 'spec_helper'

describe "user_places/edit" do
  before(:each) do
    @user_place = assign(:user_place, stub_model(UserPlace))
  end

  it "renders the edit user_place form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_place_path(@user_place), "post" do
    end
  end
end
