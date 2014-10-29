# -*- encoding : utf-8 -*-
class ReservationGroupApprovalController < ApplicationController
  def index

    reservations = ReservationGroup.confirmed

    if params[:classes]
      reservations = reservations.from_class
      unless ReservationAuth.can_create_class?(current_user)
        flash[:error]= "Você não tem acesso a esta página"
        return redirect_to dashboard_path
      end
    else
      reservations = reservations.not_from_class
    end

    if params[:filter_by] == "future"

      reservation_groups = []

      reservations.confirmed.can_decide_over(current_user).each do |reservation|
        reservation_groups << reservation if reservation.begin_date >= DateTime.now.to_date
      end

    elsif params[:filter_by] == "finished"

      reservation_groups = []

      reservations.confirmed.can_decide_over(current_user).each do |reservation|
        reservation_groups << reservation if reservation.begin_date < DateTime.now.to_date
      end

    else
      reservation_groups = reservations.confirmed.can_decide_over(current_user)

      if params[:reservation_search]
        reservation_groups = ReservationGroup.filter(reservation_groups, params[:reservation_search])
      end
    end
    @reservation_groups = ReservationGroupDecorator.decorate_collection(reservation_groups)

    @params = ReservationSearchDecorator.decorate(params[:reservation_search])

  end

  def approve

    reservation_group= ReservationGroup.find(params[:reservation_group_id])

    last_status =  reservation_group.status

    ReservationPolicy.approve_all(current_user, reservation_group)

    reservation_group.touch_with_version

    pt = PaperTrail::Version.last

    cs = pt.changeset

    cs["status"] = [last_status, reservation_group.status] unless last_status == reservation_group.status

    pt.object_changes = cs.to_yaml

    pt.save

    redirect_to check_group_reservations_path(filter_by: "future"), notice: "Reserva aprovada com sucesso."
  end

  def reject
    @justification = Justification.new(justification_params)

    reservation_group= ReservationGroup.find(params[:reservation_group_id])

    last_status =  reservation_group.status

    ReservationPolicy.reject_all(current_user, reservation_group, @justification)

    reservation_group.touch_with_version

    pt = PaperTrail::Version.last

    cs = pt.changeset

    cs["status"] = [last_status, reservation_group.status] unless last_status == reservation_group.status

    pt.object_changes = cs.to_yaml

    pt.save

    redirect_to check_group_reservations_path(filter_by: "future"), notice: "Reserva rejeitada com sucesso."
  end

  def suspend
    @justification = Justification.new(justification_params)

    reservation_group= ReservationGroup.find(params[:reservation_group_id])

    last_status =  reservation_group.status

    ReservationPolicy.suspend_all(current_user, reservation_group, @justification)

    reservation_group.touch_with_version

    pt = PaperTrail::Version.last

    cs = pt.changeset

    cs["status"] = [last_status, reservation_group.status] unless last_status == reservation_group.status

    pt.object_changes = cs.to_yaml

    pt.save

    redirect_to check_group_reservations_path(filter_by: "future"), notice: "Reserva suspensa com sucesso."
  end

  def cancel
    reservation_group= ReservationGroup.find(params[:reservation_group_id])

    last_status =  reservation_group.status

    ReservationPolicy.cancel_all(current_user, reservation_group)

    reservation_group.touch_with_version

    pt = PaperTrail::Version.last

    cs = pt.changeset

    cs["status"] = [last_status, reservation_group.status] unless last_status == reservation_group.status

    pt.object_changes = cs.to_yaml

    pt.save

    redirect_to reservation_groups_path(filter_by: "future"), notice: "Reserva cancelada com sucesso."
  end

  def justify_status
    @justification = Justification.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  def import_spreadsheet
    respond_to do |format|
      format.html
      format.js
    end
  end

  def process_spreadsheet
    s = Roo::Excelx.new(params[:import][:spreadsheet].path, file_warning: :ignore)

    i = 2
    hash = {}

    while i <= s.last_row

      if s.cell(i, 1)
        hash[:name] = s.cell(i, 1)
        hash[:place_id] = Place.find_by(code: s.cell(i, 2)).id
        hash[:responsible] = s.cell(i, 3)
        hash[:reason] = s.cell(i, 4)
        hash[:notes] = s.cell(i, 5)

        hash[:repetitions] = {}
      end

      hash[:repetitions][i-2] = {begin_date: s.cell(i, 6).strftime("%d/%m/%Y"),
                                 end_date: s.cell(i, 7).strftime("%d/%m/%Y"),
                                 weekly_repeat: s.cell(i, 8).to_i.to_s.chars.map{ |x|
                                   (x.to_i - 1).to_s
                                 },
                                 begin_time: Time.at(s.cell(i, 9).to_f).gmtime.strftime('%R').to_s,
                                 end_time: Time.at(s.cell(i, 10).to_f).gmtime.strftime('%R').to_s,
                                }



      i+= 1

    end


    hash[:user_id] = current_user.id

    @reservation_group = ReservationGroup.new(name: hash[:name],
     notes: hash[:notes])

    group_processor = ReservationGroupProcessor.new(hash)

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

  def justification_params
    params.require(:justification).permit(:reason).
      merge(user_id: current_user.id, reservation_group_id: params[:reservation_group_id])
  end
end
