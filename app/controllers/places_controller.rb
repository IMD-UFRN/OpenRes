# -*- encoding : utf-8 -*-
class PlacesController < ApplicationController
  load_and_authorize_resource

  before_action :set_place, only: [:show, :edit, :update, :destroy, :get_reservations]

  before_action :load_dates, only: [:get_reservations, :slot_search]

  # GET /places
  # GET /places.json
  def index
    @sectors = Sector.all

    if params[:place] && !params[:place][:code].blank?

      code = params[:place][:code]
      @places = Place.where('code LIKE ?', "%#{code.capitalize}%") + Place.where('name LIKE ?', "%#{code}%")

      @places = PlaceDecorator.decorate_collection(@places)
    end

  end

  # GET /places/1
  # GET /places/1.json
  def show
    reservations = @place.reservations.not_grouped
    reservation_groups = ReservationGroup.from_place(@place)

    if params[:filter_by] == "future"
      reservations= reservations.from_future
      reservation_groups= reservation_groups.from_future

    elsif params[:filter_by] == "finished"
      reservations= reservations.from_past
      reservation_groups= reservation_groups.from_past
    end

    # byebug

    @reservations = ReservationDecorator.decorate_collection(reservations.page(params[:reservation_page]).per(5))
    @reservation_groups = ReservationGroupDecorator.decorate_collection(reservation_groups.page(params[:reservation_group_page]).per(3))
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

    @reservations = @reservations.where(date: @date) if @date

    @reservations.order!(:begin_time)

    @reservations = @reservations.reject { |r| r.reservation_group && !r.reservation_group.confirmed_at }

    @responsibles = @place.can_be_decided_by

    @objects = @place.object_resources

    @similar_places = @place.similar_places & Place.get_empty_places(@date, @begin_time, @end_time)
  end

  def slot_search

    @places = Place.get_empty_places(@date, @begin_time, @end_time)

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

    def load_dates
      begin
        @date = Date.strptime(params[:date], "%d/%m/%Y")
        @begin_time = Time.parse("2000-01-01 "+params[:begin_time]+":00 UTC")
        @end_time = Time.parse("2000-01-01 "+params[:end_time]+":00 UTC")
      rescue
        @date = nil
        @begin_time = nil
        @end_time = nil
      end
    end
end
