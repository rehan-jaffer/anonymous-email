uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

RedisPagination.configure do |configuration|
  configuration.redis = REDIS
  configuration.page_size = 10
end
