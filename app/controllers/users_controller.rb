class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      provide_token_for(@user)
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
