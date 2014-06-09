# -*- encoding : utf-8 -*-
class CheckinController < ApplicationController
  def index
    @places = Place.where(reservable: true).in_groups_of(10)

    0.upto(@places.length - 1) do |i|
      @places[i] = PlaceDecorator.decorate_collection(@places[i])
    end
  end

  def checkin_details
    @place = Place.find(params[:place_id])

    @active = @place.active_checkin

    @active = @active.decorate if @active

    @finished = CheckinDecorator.decorate_collection(@place.past_checkins.where(date: Date.today))

    @reservations = ReservationDecorator.decorate_collection(@place.reservations.approved.where(date: Date.today).select { |r| !r.done? })
  end

  def checkin
    #adicionar as validacoes

    @checkin = Checkin.create(reservation_id: params[:reservation_id], date: Date.today, begin_time: Time.now - 3.hours)

    redirect_to :checkin_list
  end

  def checkout
    #adicionar as validacoes

    @checkin = Checkin.find(params[:checkin_id])
    @checkin.end_time = Time.now - 3.hours
    @checkin.save

    redirect_to :checkin_list
  end

end
