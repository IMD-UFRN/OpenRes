# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  layout 'homepage'
  skip_authorize_resource

  def index
  end

  def about
  end

  def whats_new
  end

end
