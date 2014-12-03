class ImporterController < ApplicationController

  def import_spreadsheet
    @url = params[:url]
    respond_to do |format|
      format.html
      format.js
    end
  end

end
