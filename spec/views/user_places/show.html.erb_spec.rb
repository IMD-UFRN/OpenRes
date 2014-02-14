# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "user_places/show" do
  before(:each) do
    @user_place = assign(:user_place, stub_model(UserPlace))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
