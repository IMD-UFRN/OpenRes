class HomeController < ApplicationController
  skip_authorize_resource

  def index
  end

  def not_authorized
  end
end
