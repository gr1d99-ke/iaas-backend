class SessionsController < ApplicationController
  def create
    @result = UserSessionService.call(session_params)

    if @result.user
      provide_token
      render_resource(@result.user)
    else
      invalid_credentials!(@result)
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def provide_token
    token = generate_auth_token(@result.user)
    attach_auth_token(token)
  end
end
