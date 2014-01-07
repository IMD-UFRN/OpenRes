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
        format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
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
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
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
    @user = UserDecorator.decorate(current_user)

    @open_sector_reservations = ReservationDecorator.decorate_collection(Reservation.open_for_sector(@user.sector))
    @approved_sector_reservations = ReservationDecorator.decorate_collection(Reservation.approved_for_sector(@user.sector))
    @rejected_sector_reservations = ReservationDecorator.decorate_collection(Reservation.rejected_for_sector(@user.sector))
  end

  def finished
    @user = UserDecorator.decorate(current_user)

    @open_sector_reservations = ReservationDecorator.decorate_collection(Reservation.open_and_finished_for_sector(@user.sector))
    @approved_sector_reservations = ReservationDecorator.decorate_collection(Reservation.approved_and_finished_for_sector(@user.sector))
    @rejected_sector_reservations = ReservationDecorator.decorate_collection(Reservation.rejected_and_finished_for_sector(@user.sector))
  end

  def future
    @user = UserDecorator.decorate(current_user)
    
    @open_sector_reservations = ReservationDecorator.decorate_collection(Reservation.open_for_sector_to_come(@user.sector))
    @approved_sector_reservations = ReservationDecorator.decorate_collection(Reservation.approved_for_sector_to_come(@user.sector))
    @rejected_sector_reservations = ReservationDecorator.decorate_collection(Reservation.rejected_for_sector_to_come(@user.sector))
  end

  def user_all_reservations

    @user = UserDecorator.decorate(current_user)
    @open_reservations = ReservationDecorator.decorate_collection(Reservation.open_from_user(@user))
    @approved_reservations = ReservationDecorator.decorate_collection(Reservation.approved_from_user(@user))
    @rejected_reservations = ReservationDecorator.decorate_collection(Reservation.rejected_from_user(@user))

  end

  def user_future_reservations

    @user = UserDecorator.decorate(current_user)
    @open_reservations = ReservationDecorator.decorate_collection(Reservation.open_from_user_to_come(@user))
    @approved_reservations = ReservationDecorator.decorate_collection(Reservation.approved_from_user_to_come(@user))
    @rejected_reservations = ReservationDecorator.decorate_collection(Reservation.rejected_from_user_to_come(@user))

  end

  def user_finished_reservations
    @user = UserDecorator.decorate(current_user)
    @open_reservations = ReservationDecorator.decorate_collection(Reservation.open_and_finished_from_user(@user))
    @approved_reservations = ReservationDecorator.decorate_collection(Reservation.approved_and_finished_from_user(@user))
    @rejected_reservations = ReservationDecorator.decorate_collection(Reservation.rejected_and_finished_from_user(@user))
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:begin_time, :end_time, :reason, :place_id)
       .merge(user_id: current_user.id, status: "pending")
    end
end
