class ReservationsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = ReservationDecorator.decorate_collection(current_user.reservations)
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
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

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: 'Reserva criada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @reservation }
      else
        format.html { render action: 'new' }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
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
      format.html { redirect_to reservations_url }
      format.json { head :no_content }
    end
  end

  def all
    @open_sector_reservations = ReservationDecorator.decorate_collection(Reservation.open_for_sector(current_user.object.sector))
    @approved_sector_reservations = ReservationDecorator.decorate_collection(Reservation.approved_for_sector(current_user.object.sector))
    @rejected_sector_reservations = ReservationDecorator.decorate_collection(Reservation.rejected_for_sector(current_user.object.sector))
  end

  def finished
    @open_sector_reservations = ReservationDecorator.decorate_collection(Reservation.open_and_finished_for_sector(current_user.object.sector))
    @approved_sector_reservations = ReservationDecorator.decorate_collection(Reservation.approved_and_finished_for_sector(current_user.object.sector))
    @rejected_sector_reservations = ReservationDecorator.decorate_collection(Reservation.rejected_and_finished_for_sector(current_user.object.sector))
  end

  def future
    @open_sector_reservations = ReservationDecorator.decorate_collection(Reservation.open_for_sector_to_come(current_user.object.sector))
    @approved_sector_reservations = ReservationDecorator.decorate_collection(Reservation.approved_for_sector_to_come(current_user.object.sector))
    @rejected_sector_reservations = ReservationDecorator.decorate_collection(Reservation.rejected_for_sector_to_come(current_user.object.sector))
  end

  def user_all_reservations

    @open_reservations = ReservationDecorator.decorate_collection(Reservation.open_from_user(current_user.object))
    @approved_reservations = ReservationDecorator.decorate_collection(Reservation.approved_from_user(current_user.object))
    @rejected_reservations = ReservationDecorator.decorate_collection(Reservation.rejected_from_user(current_user.object))

  end

  def user_future_reservations

    @open_reservations = ReservationDecorator.decorate_collection(Reservation.open_from_user_to_come(current_user.object))
    @approved_reservations = ReservationDecorator.decorate_collection(Reservation.approved_from_user_to_come(current_user.object))
    @rejected_reservations = ReservationDecorator.decorate_collection(Reservation.rejected_from_user_to_come(current_user.object))

  end

  def user_finished_reservations
    @open_reservations = ReservationDecorator.decorate_collection(Reservation.open_and_finished_from_user(current_user.object))
    @approved_reservations = ReservationDecorator.decorate_collection(Reservation.approved_and_finished_from_user(current_user.object))
    @rejected_reservations = ReservationDecorator.decorate_collection(Reservation.rejected_and_finished_from_user(current_user.object))
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:date, :begin_time, :end_time, :reason, :place_id)
       .merge(user_id: current_user.id, status: "pending")
    end
end
