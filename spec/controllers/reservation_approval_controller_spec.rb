require 'spec_helper'

describe ReservationApprovalController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'approve'" do
    it "returns http success" do
      get 'approve'
      response.should be_success
    end
  end

  describe "GET 'reject'" do
    it "returns http success" do
      get 'reject'
      response.should be_success
    end
  end

  describe "GET 'set_pending'" do
    it "returns http success" do
      get 'set_pending'
      response.should be_success
    end
  end

end
