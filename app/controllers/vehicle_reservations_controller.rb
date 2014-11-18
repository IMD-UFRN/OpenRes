# -*- encoding : utf-8 -*-
class VehicleReservationsController < ApplicationController
  before_action :set_vehicle_reservation, only: [:show, :edit, :update, :destroy]

  # GET /vehicle_reservations
  # GET /vehicle_reservations.json
  def index

    if params[:filter_by]=="finished"
      reservations = VehicleReservation.from_past
    elsif params[:filter_by]=="future"
      reservations = VehicleReservation.from_future
    else
      reservations = VehicleReservation.all
    end

    pending_reservations = reservations.where(status: "pending")
    approved_reservations = reservations.where(status: "approved")
    rejected_reservations = reservations.where(status: "rejected")

    @pending_reservations = VehicleReservationDecorator.decorate_collection(pending_reservations)
    @approved_reservations = VehicleReservationDecorator.decorate_collection(approved_reservations)
    @rejected_reservations = VehicleReservationDecorator.decorate_collection(rejected_reservations)
  end

  # GET /vehicle_reservations/1
  # GET /vehicle_reservations/1.json
  def show
    @vehicle_reservation = VehicleReservationDecorator.decorate(VehicleReservation.find(params[:id]))
  end

  # GET /vehicle_reservations/new
  def new
    @vehicle_reservation = VehicleReservation.new
    @vehicle = Vehicle.find(params[:vehicle_id]) if params[:vehicle_id]
    @driver = Driver.find(params[:driver_id]) if params[:driver_id]
  end

  # GET /vehicle_reservations/1/edit
  def edit
  end

  # POST /vehicle_reservations
  # POST /vehicle_reservations.json
  def create
    @vehicle_reservation = VehicleReservation.new(vehicle_reservation_params)

    respond_to do |format|
      if @vehicle_reservation.save
        format.html { redirect_to @vehicle_reservation, notice: 'Reserva cadastrada com sucesso.' }
        format.json { render :show, status: :created, location: @vehicle_reservation }
      else
        format.html { render :new }
        format.json { render json: @vehicle_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicle_reservations/1
  # PATCH/PUT /vehicle_reservations/1.json
  def update
    respond_to do |format|
      if @vehicle_reservation.update(vehicle_reservation_params)
        format.html { redirect_to @vehicle_reservation, notice: 'Reserva atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @vehicle_reservation }
      else
        format.html { render :edit }
        format.json { render json: @vehicle_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicle_reservations/1
  # DELETE /vehicle_reservations/1.json
  def destroy
    @vehicle_reservation.destroy
    respond_to do |format|
      format.html { redirect_to vehicle_reservations_url, notice: 'Reserva excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle_reservation
      @vehicle_reservation = VehicleReservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vehicle_reservation_params
      params[:vehicle_reservation].permit(:date, :begin_time, :end_time, :vehicle_id, :reason, :passengers, :driver_id)
    end
end
