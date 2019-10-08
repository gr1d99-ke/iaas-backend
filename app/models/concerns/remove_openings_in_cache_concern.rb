module RemoveOpeningsInCacheConcern
  extend ActiveSupport::Concern

  included do
    after_commit do
      keys = RedisService.keys("openings*")
      RedisService.del(keys)
    end
  end
end
