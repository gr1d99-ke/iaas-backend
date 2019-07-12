APP_REDIS_NAMESPACE = "#{Rails.application.credentials.APP_NAME}_cache"

redis = if Rails.env.production?
          uri = URI.parse(ENV["REDISTOGO_URL"])
          Redis.new(:url => uri)
        elsif Rails.env.test?
          require "mock_redis"

          MockRedis.new
        else
          Redis.new
        end

Redis.current = Redis::Namespace.new(APP_REDIS_NAMESPACE, redis: redis)
