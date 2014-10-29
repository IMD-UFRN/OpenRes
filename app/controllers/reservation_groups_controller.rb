# -*- encoding : utf-8 -*-
class ReservationGroupsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :return_if_confirmed, only: [:new_reservation]

  def new
    if params[:to_class] && !ReservationAuth.can_create_class?(current_user)
      flash[:error] = "Você não possui acesso a esta página"
      redirect_to dashboard_path
    end
  end

  def edit
    @reservation_group = ReservationGroup.find(params[:id])
    reservation = @reservation_group.reservations.first
    reservation_group_struct = Struct.new(:reason, :responsible, :name, :notes, :user_id)

    @reservation_group_form = reservation_group_struct.new(reservation.reason, reservation.responsible, @reservation_group.name, @reservation_group.notes, reservation.user_id )
  end

  def update

    reservation_group_params = params[:reservation_group_form]

    @reservation_group = ReservationGroup.find(params[:id])


    last_responsible = @reservation_group.responsible
    last_reason = @reservation_group.reason
    last_user_id = @reservation_group.reservations.first.user_id

    @reservation_group.name = reservation_group_params[:name]
    @reservation_group.notes = reservation_group_params[:notes]

    # ActiveRecord::Base.transaction do

    @reservation_group.reservations.each do |r|
      r.responsible = reservation_group_params[:responsible]
      r.reason = reservation_group_params[:reason]
      r.user_id = reservation_group_params[:user_id]
      r.save
    end

    @reservation_group.touch_with_version

    @reservation_group.save

    pt = PaperTrail::Version.last

    cs = pt.changeset

    cs["responsible"] = [last_responsible,@reservation_group.responsible] unless last_responsible == @reservation_group.responsible
    cs["reason"] = [last_reason,@reservation_group.reason] unless last_reason == @reservation_group.reason
    cs["user_id"] = [last_user_id,@reservation_group.reservations.first.user_id] unless last_user_id == @reservation_group.reservations.first.user_id

    pt.object_changes = cs.to_yaml

    pt.save

    redirect_to @reservation_group, notice: "Reserva atualizada com sucesso"
  end

  def edit_period
    @reservation_group = ReservationGroup.find(params[:id])
  end

  def update_period

    @reservation_group = ReservationGroup.find(params[:id])

    group_processor = ReservationGroupProcessor.new(@reservation_group)

    unless group_processor.process?
      flash[:error] ="Nenhuma reserva criada. O horário de fim de um dos blocos é menor que o de início."
      redirect_to update_period_reservation_group_path
      return
    end

    @reservation_group.reservations.destroy_all
    @reservation_group.reservations = group_processor.reservations

    if @reservation_group.save
      redirect_to @reservation_group
    else
      flash[:error] ="Nenhuma reserva criada. Verifique se o período especificado é válido e contém os dias selecionados."
      redirect_to update_period_reservation_group_path
      return
    end


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

    @reservation_list =  ReservationListDecorator.initialize_decorator(@reservation_group.reservations.order(:date), "approve", "suspend", "reject", "cancel", "delete")

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
      redirect_to @reservation_group
    else
      flash[:error] ="Nenhuma reserva criada. Verifique se o período especificado é válido e contém os dias selecionados."
      redirect_to new_reservation_group_path
      return
    end

  end

  def new_reservation
    @reservation = Reservation.new
    @reservation.reservation_group = @reservation_group
  end

  def classes
  end

  def confirm
    @reservation_group = ReservationGroup.find(params[:reservation_group_id])

    @reservation_group.confirmed_at = DateTime.now

    @reservation_group.save

    NotifyUserMailer.send_reservation_made(@reservation_group)

    redirect_to @reservation_group, notice: "Reserva salva com sucesso"
  end

  def reservation_group_params

    return params.require(:reservation_group_form).merge(user_id: current_user.id, created_by_id: current_user.id) if current_user.role != "admin" || params[:reservation_group_form][:user_id].blank?
    params.require(:reservation_group_form).merge(created_by_id: current_user.id).permit!
  end

  def return_if_confirmed
    @reservation_group = ReservationGroup.find(params[:id])

    if @reservation_group.confirmed_at
      flash[:error] = "Você não pode criar reservas para uma reserva múltipla já confirmada!"

      redirect_to @reservation_group
    end

  end
end
