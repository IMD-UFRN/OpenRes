# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "room_types/new" do
  before(:each) do
    assign(:room_type, stub_model(RoomType).as_new_record)
  end

  it "renders new room_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", room_types_path, "post" do
    end
  end
end
