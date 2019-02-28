class UsersController < ApplicationController
  def create
    @user = User.create(user_params)

    if @user.valid?
      token = generate_auth_token(@user)
      attach_auth_token(token)
      render_resource(@user, :created)
    else
      resource_invalid!(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
