# -*- encoding : utf-8 -*-
class ReservationGroupProcessor
  def initialize(hash)
    @hash = hash
    @group = ReservationGroup.new(name: hash[:name], user_id: hash[:user_id],
      notes: hash[:notes])


  end

  def process
    reservations = []

    @hash[:repetitions].each do |key, repetition|
      days = select_days(repetition)

      days.each do |day|
        reservations << Reservation.new(date: day, begin_time: repetition[:begin_time],
          end_time: repetition[:end_time], status: 'pending', reason: @hash[:reason],
          user_id: @hash[:user_id], place_id: @hash[:place_id])
      end
    end

    @reservations = reservations
  end

  def save
    ActiveRecord::Base.transaction do
      reservations = []

      @reservations.each do |reservation|
        raise Exception.new reservation.errors.inspect unless reservation.valid?

        @group.reservations << reservation
      end

      @group.save
    end
  end

  private

  def select_days(repetition)
    begin_date = Date.parse(repetition[:begin_date])
    end_date = Date.parse(repetition[:end_date])
    weekly_repeat = repetition[:weekly_repeat].map(&:to_i)

    result = (begin_date..end_date).to_enum.select {|k| weekly_repeat.include?(k.wday)}
  end
end

class ReservationGroupsController < ApplicationController
  before_filter :authenticate_user!

  def new
  end

  def index

     if params[:filter_by] == "future"
       @reservation_groups = ReservationGroupDecorator.decorate_collection(ReservationGroup.from_user(current_user).from_future)
     elsif params[:filter_by] == "finished"
       @reservation_groups = ReservationGroupDecorator.decorate_collection(ReservationGroup.from_user(current_user).from_past)
     else
      @reservation_groups = ReservationGroupDecorator.decorate_collection(ReservationGroup.from_user(current_user))
     end
  end

  def show
    @reservation_group =  ReservationGroupDecorator.decorate(ReservationGroup.find(params[:id]))
  end

  def create
    @reservation_group = ReservationGroup.new(name: reservation_group_params[:name],
     notes: reservation_group_params[:notes])

    group_processor = ReservationGroupProcessor.new(reservation_group_params)
    group_processor.process
    group_processor.save

    NotifyUserMailer.send_reservation_made(@reservation_group).deliver

    redirect_to @reservation_group
  end

  def reservation_group_params
    params.require(:reservation_group_form).merge(user_id: current_user.id)
  end
end
