class SessionsController < ApplicationController
  def create
    @user = User.find_by_email(session_params[:email])&.authenticate(session_params[:password])
    if @user
      provide_token
      render_resource(@user)
    else
      unauthorized!
    end
  end

  private

  def session_params
    params.require(:sessions).permit(:email, :password)
  end

  def provide_token
    token = generate_auth_token(@user, session_params[:password])
    attach_auth_token(token)
  end
end
