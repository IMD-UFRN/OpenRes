class ClassMonitorsController < ApplicationController
  before_action :set_class_monitor, only: [:show, :edit, :update, :destroy]

  # GET /class_monitors
  # GET /class_monitors.json
  def index
    @class_monitors = ClassMonitor.all
  end

  # GET /class_monitors/1
  # GET /class_monitors/1.json
  def show
  end

  # GET /class_monitors/new
  def new
    @class_monitor = ClassMonitor.new
  end

  # GET /class_monitors/1/edit
  def edit
  end

  # POST /class_monitors
  # POST /class_monitors.json
  def create
    @class_monitor = ClassMonitor.new(class_monitor_params)

    respond_to do |format|
      if @class_monitor.save
        format.html { redirect_to @class_monitor, notice: 'Monitor de Sala criado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @class_monitor }
      else
        format.html { render action: 'new' }
        format.json { render json: @class_monitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /class_monitors/1
  # PATCH/PUT /class_monitors/1.json
  def update
    respond_to do |format|
      if @class_monitor.update(class_monitor_params)
        format.html { redirect_to @class_monitor, notice: 'Monitor de Sala atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @class_monitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_monitors/1
  # DELETE /class_monitors/1.json
  def destroy
    @class_monitor.destroy
    respond_to do |format|
      format.html { redirect_to class_monitors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_class_monitor
      @class_monitor = ClassMonitor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def class_monitor_params
      params[:class_monitor].permit!
    end
end
