# -*- encoding : utf-8 -*-
class ProfileController < ApplicationController
  before_filter :authenticate_user!

  def profile
    @user = current_user
    @reservations= ReservationDecorator.decorate_collection(@user.reservations)
  end

  def edit
    @user = current_user

    if @user.role == "sector_admin"
      @functions = [["Adminitração de Setor", "sector_admin"]]
    elsif @user.role == "secretary"
       @functions = [["Secretaria", "secretary"]]
    elsif @user.role == "basic"
       @functions = [["Básica", "basic"]]
    else 
       @functions =[["Adminitração de Setor", "sector_admin"], ["Secretaria", "secretary"], ["Básica", "basic"]]
    end
  end

  def update
    @user = Users::UserService.update(current_user, user_params)

    respond_to do |format|
      if @user.errors.any?
        format.html { render 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to profile_path, notice: 'User atualizado com sucesso.' }
        format.json { head :no_content }
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:id, :email, :name, :cpf, :role, :sector_id,
       :old_password, :password, :password_confirmation)
    end
end
