class UsersController < ApplicationController
  def create
    @user = User.create(user_params)

    if @user.valid?
      token = generate_auth_token(@user, user_params[:password])
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

  def resource_invalid!(resource)
    render json: {
      status: I18n.t("errors.unprocessable_entity.status"),
      title: I18n.t("errors.unprocessable_entity.title"),
      detail: I18n.t("errors.unprocessable_entity.detail"),
      errors: resource.errors
    }, status: :unprocessable_entity
  end
end
