# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each) do
    Redis.current.redis.flushdb
  end
end
