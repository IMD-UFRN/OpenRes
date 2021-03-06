# -*- encoding : utf-8 -*-
class ProfileController < ApplicationController
  #authorize_resource :class => false
  before_action :authenticate_user!

  def profile
    @user = current_user
    @reservations= ReservationDecorator.decorate_collection(@user.reservations)
    @functions_hash ={"admin"        => "Administrador do Sistema",
                      "sector_admin" => "Administração de Setor",
                      "secretary"    => "Secretaria",
                      "basic"        => "Básica",
                      "receptionist" => "Recepção"}
  end

  def edit
    @user = current_user

    if @user.role == "sector_admin"
      @functions = [["Administração de Setor", "sector_admin"]]
    elsif @user.role == "secretary"
       @functions = [["Secretaria", "secretary"]]
    elsif @user.role == "basic"
       @functions = [["Básica", "basic"]]
    elsif @user.role == "receptionist"
       @functions = [["Recepção", "receptionist"]]
    else
       @functions =[["Administração de Setor", "sector_admin"], ["Secretaria", "secretary"], ["Básica", "basic"], ["Recepção", "receptionist"]]
    end

  end

  def update
    @user = Users::UserService.update(current_user, user_params)

    respond_to do |format|
      if @user.errors.any?
        format.html { render 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      else
        format.html {
          sign_in(current_user, :bypass => true)
          redirect_to profile_path, notice: "Dados alterados com sucesso"
        }
        format.json { head :no_content }
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:id, :email, :name, :cpf, :role,
       :old_password, :password, :password_confirmation)
    end
end
