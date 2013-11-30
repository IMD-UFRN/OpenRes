require 'spec_helper'

describe "room_types/show" do
  before(:each) do
    @room_type = assign(:room_type, stub_model(RoomType))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
