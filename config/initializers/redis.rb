redis_config =  Rails.env.development? ? { host: '127.0.0.1', port: 6379 } : { host: ENV['http://dev-api.losev-formulas.com'], port: 6379}


$redis = Redis::Namespace.new("LOSEV_FORMULAS", redis: Redis.new(redis_config) )