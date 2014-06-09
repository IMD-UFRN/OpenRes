# -*- encoding : utf-8 -*-
class UserDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def dashboard
    render "dashboard/#{object.role}"
  end

  def menu
    render "menu/#{object.role}"
  end

  def pt_role
    functions= {"sector_admin" => "Administração de Setor",
                "secretary"=> "Secretaria",
                "admin"=> "Administrador do Sistema",
                "receptionist" => "Recepção",
                "basic" => "Básica"}

    functions[object.role]
  end

end
