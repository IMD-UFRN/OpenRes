# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  before_filter :authenticate_user!, :except => [:about]

  before_filter :reservation_counter
  before_filter :reservation_group_counter

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :back, :alert => "Você não possui acesso a esta página"
  end

  def after_sign_in_path_for(resource)
    dashboard_path
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

  def current_user
    UserDecorator.decorate(super) unless super.nil?
  end

  def reservation_counter
    @pending_counter = Reservation.can_decide_over(current_user).pending.from_future.not_grouped.length
  end

  def reservation_group_counter

    @pending_group_counter = 0

    ReservationGroup.confirmed.can_decide_over(current_user).each do |reservation|
      @pending_group_counter += 1 if reservation.begin_date >= DateTime.now.to_date
    end

  end

end
