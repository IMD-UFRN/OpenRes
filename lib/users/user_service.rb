# -*- encoding : utf-8 -*-
class Users::UserService
  attr_reader :user

  def self.create(user_params)
    user = User.new(user_params)

    password = Devise.friendly_token.first(10)
    user.password = password
    user.password_confirmation = password

    UserMailer.new_user(user, password).deliver if user.save

    return user
  end

  def self.update(user, user_params)
    if user.valid_password?(user_params[:old_password])
      user.update(user_params.except(:old_password))
    else
      user.errors.add(:old_password, "Senha incorreta")
    end

    return user
  end

end
