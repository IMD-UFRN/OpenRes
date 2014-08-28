# -*- encoding : utf-8 -*-
class ReservationsController < ApplicationController
  load_and_authorize_resource

  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json

  def select_reservation
  end

  def index

    if params[:filter_by] == "future"
      @pending_reservations = ReservationDecorator.decorate_collection(Reservation.from_user(current_user).pending.from_future.not_grouped)
      @approved_reservations = ReservationDecorator.decorate_collection(Reservation.from_user(current_user).approved.from_future.not_grouped)
      @rejected_reservations = ReservationDecorator.decorate_collection(Reservation.from_user(current_user).rejected.from_future.not_grouped)
    elsif params[:filter_by] == "finished"
      @pending_reservations = ReservationDecorator.decorate_collection(Reservation.from_user(current_user).pending.from_past.not_grouped)
      @approved_reservations = ReservationDecorator.decorate_collection(Reservation.from_user(current_user).approved.from_past.not_grouped)
      @rejected_reservations = ReservationDecorator.decorate_collection(Reservation.from_user(current_user).rejected.from_past.not_grouped)
    else
      @pending_reservations = ReservationDecorator.decorate_collection(Reservation.from_user(current_user).pending.not_grouped)
      @approved_reservations = ReservationDecorator.decorate_collection(Reservation.from_user(current_user).approved.not_grouped)
      @rejected_reservations = ReservationDecorator.decorate_collection(Reservation.from_user(current_user).rejected.not_grouped)
    end

  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    model = Reservation.find(params[:id])
    @reservation = ReservationDecorator.decorate(model)
    @conflicts = ReservationDecorator.decorate_collection(Reservation.conflicting(model))
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    @conflicts = Reservation.conflicting(@reservation)

    respond_to do |format|
      if @conflicts.empty? and @reservation.save
        NotifyUserMailer.send_reservation_made(@reservation)

        format.html { redirect_to @reservation, notice: 'Reserva criada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @reservation }
      else
        format.html { render action: 'new' }
        format.json { render json: [@conflicts, @reservation.errors], status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reserva criada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = 'Reserva excluída com sucesso.' 
        return redirect_to reservations_url unless @reservation.reservation_group
        redirect_to @reservation.reservation_group
      }
      format.json { head :no_content }
    end
  end

  def preview
    @place = Place.find(params[:place_id])
    @date = Date.parse(params[:date], '%d/%m/%Y') if params[:date]

    @reservations = ReservationDecorator.decorate_collection(
      Reservation.where(date: @date, place_id: params[:place_id]))

    render :partial => 'place_preview', :content_type => 'text/html'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      return params.require(:reservation).permit(:date, :begin_time, :end_time, :reason, :responsible, :place_id)
       .merge(user_id: current_user.id, status: "pending") if current_user.role != "admin" || params[:reservation][:user_id].blank?

      params.require(:reservation).permit(:date, :begin_time, :end_time, :reason, :responsible, :place_id, :user_id)
        .merge(status: "pending")
    end
end
