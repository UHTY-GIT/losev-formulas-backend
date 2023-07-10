redis_config = { host: '127.0.0.1', port: 6379 }

$redis = Redis::Namespace.new("LOSEV_FORMULAS", redis: Redis.new(redis_config) )