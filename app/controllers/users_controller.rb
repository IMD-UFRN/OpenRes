# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if current_user.role == "admin"
      @users = UserDecorator.decorate_collection(User.all)
    elsif current_user.role == "secretary" || current_user.role == "sector_admin"
      @users = UserDecorator.decorate_collection(User.where(sector_id: current_user.sector))
    else
      @users = []
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show
    @reservations= ReservationDecorator.decorate_collection(@user.reservations)
    @functions_hash ={"admin"        => "Administrador do Sistema",
                      "sector_admin" => "Administração de Setor",
                      "secretary"    => "Secretaria",
                      "basic"        => "Básica",
                      "receptionist" => "Recepção"}
  end

  def edit
    @functions =[["Administração de Setor", "sector_admin"], ["Secretaria", "secretary"], ["Básica", "basic"], ["Recepção", "receptionist"]]
  end

  # GET /users/new
  def new
    @user = User.new
    @functions =[["Administração de Setor", "sector_admin"], ["Secretaria", "secretary"], ["Básica", "basic"], ["Recepção", "receptionist"], ["Administrador do Sistema", "admin"]]
  end

  # POST /users
  # POST /users.json
  def create
    @user = Users::UserService.create(user_params)

    respond_to do |format|
      if @user.errors.any?
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to @user, notice: 'Usuário cadastrado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @user }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'Usuário atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :email, :name, :cpf, :role, :sector_id)
    end

end
