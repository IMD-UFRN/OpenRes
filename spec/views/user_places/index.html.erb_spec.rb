# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "user_places/index" do
  before(:each) do
    assign(:user_places, [
      stub_model(UserPlace),
      stub_model(UserPlace)
    ])
  end

  it "renders a list of user_places" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
