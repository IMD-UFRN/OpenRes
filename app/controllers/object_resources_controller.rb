# -*- encoding : utf-8 -*-
class ObjectResourcesController < ApplicationController
  load_and_authorize_resource

  before_action :set_object_resource, only: [:show, :edit, :update, :destroy]

  # GET /object_resources
  # GET /object_resources.json
  def index
    @object_resources = ObjectResource.all
  end

  # GET /object_resources/1
  # GET /object_resources/1.json
  def show
  end

  # GET /object_resources/new
  def new
    @object_resource = ObjectResource.new
  end

  # GET /object_resources/1/edit
  def edit
  end

  # POST /object_resources
  # POST /object_resources.json
  def create
    @object_resource = ObjectResource.new(object_resource_params)

    respond_to do |format|
      if @object_resource.save
        format.html { redirect_to @object_resource, notice: 'Object resource was successfully created.' }
        format.json { render action: 'show', status: :created, location: @object_resource }
      else
        format.html { render action: 'new' }
        format.json { render json: @object_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /object_resources/1
  # PATCH/PUT /object_resources/1.json
  def update
    respond_to do |format|
      if @object_resource.update(object_resource_params)
        format.html { redirect_to @object_resource, notice: 'Object resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @object_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /object_resources/1
  # DELETE /object_resources/1.json
  def destroy
    @object_resource.destroy
    respond_to do |format|
      format.html { redirect_to object_resources_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_object_resource
      @object_resource = ObjectResource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def object_resource_params
      params.require(:object_resource).permit(:name, :description)
    end
end
