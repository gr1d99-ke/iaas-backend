class SessionsController < ApplicationController
  def create
    service = UserSessionService.call(session_params)

    @user = service.user

    if @user
      provide_token
      render_resource(@user)
    else
      invalid_credentials!(service)
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def provide_token
    token = generate_auth_token(@user)
    attach_auth_token(token)
  end
end
