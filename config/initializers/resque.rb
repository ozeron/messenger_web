require 'resque'
require 'resque/server'

configuration = {
  host:     ENV['RESQUE_REDIS_HOST'],
  port:     ENV['RESQUE_REDIS_PORT'],
  password: ENV['RESQUE_REDIS_PASS'],
  db:       ENV['RESQUE_REDIS_DB_NUMBER']
}.compact

Resque.redis = Redis.new(configuration)
