# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "room_types/index" do
  before(:each) do
    assign(:room_types, [
      stub_model(RoomType),
      stub_model(RoomType)
    ])
  end

  it "renders a list of room_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
