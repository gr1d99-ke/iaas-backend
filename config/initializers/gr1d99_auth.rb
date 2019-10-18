Gr1d99Auth.configure do |config|
  config.jwt_key    = "simple-key"
  config.jwt_verify = true
  config.jwt_algorithm = 'HS512'
  config.jwt_exp = 36_000
  config.time_zone = "Africa/Nairobi"
end
