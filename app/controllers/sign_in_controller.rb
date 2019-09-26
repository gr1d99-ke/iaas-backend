class SignInController < ApplicationController
  def create
    @sign_in_session = SignInSession.new(sign_in_params)

    if @sign_in_session.user
      token = generate_auth_token(@sign_in_session.user)
      attach_auth_token(token)
      render_resource(@sign_in_session.user)
    else
      invalid_credentials!(@sign_in_session)
    end
  end

  private

  def sign_in_params
    params.require(:session).permit(:email, :password)
  end
end
