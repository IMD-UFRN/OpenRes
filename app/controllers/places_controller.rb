# -*- encoding : utf-8 -*-
class PlacesController < ApplicationController
  load_and_authorize_resource

  before_action :set_place, only: [:show, :edit, :update, :destroy, :get_reservations]

  # GET /places
  # GET /places.json
  def index
    @sectors = Sector.all
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @reservations= ReservationDecorator.decorate_collection(@place.reservations.not_grouped)
    @reservation_groups= ReservationGroupDecorator.decorate_collection(ReservationGroup.from_place(@place))
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Sala cadastrada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @place }
      else
        format.html { render action: 'new' }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place, notice: 'Sala atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end

  def get_reservations
    @reservations = @place.reservations.where("status = ? or status = ?", "approved", "pending" )

    begin
      date = Date.strptime(params[:date], "%d/%m/%Y")
    rescue
      date = nil
    end

    @reservations = @reservations.where(date: date) if date

    @reservations.order!(:date)

    @responsibles = @place.can_be_decided_by


    @objects = @place.object_resources
    
    @similar_places = @place.similar_places

    #render json: @place.attributes.merge(reservations: reservations).merge(users: users)
  end

  def slot_search

    @places = []

    Place.reservable.each do |place|
      mockup_reservation = Reservation.new(date: params[:date], begin_time: params[:begin_time], end_time: params[:end_time], place_id: place.id)

      @places << place if Reservation.conflicting(mockup_reservation).empty?

    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name, :code, :capacity, :reservable, :room_type_id, :sector_ids => [], :object_resource_ids => [])
    end
end
