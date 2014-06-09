# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CheckinController do

  describe "GET 'checkin'" do
    it "returns http success" do
      get 'checkin'
      response.should be_success
    end
  end

  describe "GET 'checkout'" do
    it "returns http success" do
      get 'checkout'
      response.should be_success
    end
  end

  describe "GET 'checkin_details'" do
    it "returns http success" do
      get 'checkin_details'
      response.should be_success
    end
  end

end
