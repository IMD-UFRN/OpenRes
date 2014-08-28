# -*- encoding : utf-8 -*-
class ReservationGroupProcessor
  def initialize(hash)
    @hash = hash
    @group = ReservationGroup.new(name: hash[:name], user_id: hash[:user_id],
      notes: hash[:notes])
  end

  def process?
    reservations = []

    @hash[:repetitions].each do |key, repetition|
      days = select_days(repetition)

      if repetition[:begin_time] > repetition[:end_time]
        return false
      end

      days.each do |day|
        reservations << Reservation.new(date: day, begin_time: repetition[:begin_time],
          end_time: repetition[:end_time], status: 'pending', reason: @hash[:reason],
          user_id: @hash[:user_id], place_id: @hash[:place_id], responsible: @hash[:responsible])
      end
    end

    @reservations = reservations

    return true
  end

  def save
    return nil if @reservations.nil?
    return nil if @reservations.empty?

    ActiveRecord::Base.transaction do
      reservations = []

      @reservations.each do |reservation|
        raise Exception.new reservation.errors.inspect unless reservation.valid?

        @group.reservations << reservation
      end

      @group.save
    end

    return @group
  end

  private

  def select_days(repetition)
    begin_date = Date.parse(repetition[:begin_date])
    end_date = Date.parse(repetition[:end_date])
    weekly_repeat = repetition[:weekly_repeat].delete_if(&:blank?).map(&:to_i)

    result = (begin_date..end_date).to_enum.select { |k| weekly_repeat.include?(k.wday) }
  end
end

class ReservationGroupsController < ApplicationController
  before_filter :authenticate_user!

  def new
  end

  def edit
    @reservation_group = ReservationGroup.find(params[:id])
    reservation = @reservation_group.reservations.first
    reservation_group_struct = Struct.new(:reason, :responsible, :name, :notes)

    @reservation_group_form = reservation_group_struct.new(reservation.reason, reservation.responsible, @reservation_group.name, @reservation_group.notes )
  end

  def update

    reservation_group_params = params[:reservation_group_form]

    @reservation_group = ReservationGroup.find(params[:id])

    @reservation_group.name = reservation_group_params[:name]
    @reservation_group.notes = reservation_group_params[:notes]

    @reservation_group.reservations.each do |r|
      r.responsible = reservation_group_params[:responsible]
      r.reason = reservation_group_params[:reason]
      r.save
    end

    @reservation_group.save

    redirect_to @reservation_group, notice: "Reserva atualizada com sucesso"
  end

  def index

     if params[:filter_by] == "future"
       @reservation_groups = ReservationGroupDecorator.decorate_collection(ReservationGroup.from_user(current_user).from_future.select{ |r|
         r.status != "canceled"
         })
     elsif params[:filter_by] == "finished"
       @reservation_groups = ReservationGroupDecorator.decorate_collection(ReservationGroup.from_user(current_user).from_past.select{ |r|
         r.status != "canceled"
         })
     else
      @reservation_groups = ReservationGroupDecorator.decorate_collection(ReservationGroup.from_user(current_user).select{ |r|
        r.status != "canceled"
        })
     end
  end

  def show
    @reservation_group =  ReservationGroupDecorator.decorate(ReservationGroup.find(params[:id]))
  end

  def create
    @reservation_group = ReservationGroup.new(name: reservation_group_params[:name],
     notes: reservation_group_params[:notes])

    group_processor = ReservationGroupProcessor.new(reservation_group_params)

    unless group_processor.process?
      flash[:error] ="Nenhuma reserva criada. O horário de fim de um dos blocos é menor que o de início."
      redirect_to new_reservation_group_path
      return
    end

    @reservation_group = group_processor.save

    if @reservation_group
      NotifyUserMailer.send_reservation_made(@reservation_group)
      redirect_to @reservation_group
    else
      flash[:error] ="Nenhuma reserva criada. Verifique se o período especificado é válido e contém os dias selecionados."
      redirect_to new_reservation_group_path
      return
    end

  end

  def confirm
    @reservation_group = ReservationGroup.find(params[:reservation_group_id])

    @reservation_group.confirmed_at = DateTime.now

    @reservation_group.save

    redirect_to @reservation_group, notice: "Reserva salva com sucesso"
  end

  def reservation_group_params
    return params.require(:reservation_group_form).merge(user_id: current_user.id) if current_user.role != "admin" || params[:reservation_group_form][:user_id].blank?
    params.require(:reservation_group_form).permit!
  end
end
