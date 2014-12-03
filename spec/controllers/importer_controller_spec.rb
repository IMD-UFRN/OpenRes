require 'spec_helper'

describe ImporterController do

  describe "GET 'import_spreadsheet'" do
    it "returns http success" do
      get 'import_spreadsheet'
      response.should be_success
    end
  end

end
