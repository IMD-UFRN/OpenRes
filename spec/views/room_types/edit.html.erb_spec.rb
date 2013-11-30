require 'spec_helper'

describe "room_types/edit" do
  before(:each) do
    @room_type = assign(:room_type, stub_model(RoomType))
  end

  it "renders the edit room_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", room_type_path(@room_type), "post" do
    end
  end
end
