module RedisService
  module_function

  def current
    Redis.current
  end

  def get(key)
    current.get(key)
  end

  def set(key, value)
    current.set(key, value)
  end

  def del(*keys)
    current.del(keys)
  end
end
