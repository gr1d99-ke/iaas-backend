Gr1d99Auth.configure do |config|
  config.jwt_key    = Rails.application.credentials.secret_key_base
  config.jwt_verify = true
  config.jwt_algorithm = Rails.application.credentials.JWT[:algorithm]
  config.jwt_exp = Rails.application.credentials.JWT[:exp]
  config.time_zone = "Africa/Nairobi"
end
