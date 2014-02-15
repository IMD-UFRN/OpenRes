class UserCreateService
  attr_reader :user

  def initialize(user)
    @user = user

    @password = Devise.friendly_token.first(10)
    @user.password = @password
    @user.password_confirmation = @password
  end

  def save
    result = @user.save
    UserMailer.new_user(@user, @password).deliver if result
    result
  end
end