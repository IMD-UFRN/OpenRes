class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def set_locale
    if params[:locale].blank?
      I18n.locale = :'pt-BR'
    else
      I18n.locale = params[:locale]
    end
  end

  # ensure locale persists
  def default_url_options(options={})
    {:locale => I18n.locale}
  end
end
