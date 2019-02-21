class ApplicationController < ActionController::API
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def generate_auth_token(user, password)
    payload = { email: user.email }
    JwtToken::JwtToken.encode(payload, password)
  end

  def attach_auth_token(token)
    headers["x-access-token"] = token
  end

  def render_resource(resource, status = :ok)
    render json: resource, status: status
  end

  def unauthorized!
    render json: {
      status: I18n.t("errors.unauthorized.status"),
      title: I18n.t("errors.unauthorized.title"),
      detail: I18n.t("errors.unauthorized.detail"),
      errors: [I18n.t("errors.unauthorized.error_message")]
    }, status: :unauthorized
  end
end
