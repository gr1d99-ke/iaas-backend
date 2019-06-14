APP_REDIS_NAMESPACE = "#{Rails.application.credentials.APP_NAME}_cache"
Redis.current = Redis::Namespace.new(APP_REDIS_NAMESPACE, redis: Redis.new)
