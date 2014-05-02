# -*- encoding : utf-8 -*-
class UserMailer < ActionMailer::Base
  default from: "naoresponder@imd.ufrn.br"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_user.subject
  #
  def new_user(user, password)
    @user = user
    @password = password

    mail to: user.email, subject: "[IMD- UFRN] Nova Conta no Gerenciador de Espaço Físico"
  end
end
