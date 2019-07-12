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

  def del(keys)
    keys = "" if keys.blank?
    current.del(keys)
  end

  def keys(pattern = "*")
    current.keys(pattern)
  end
end
