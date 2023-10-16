require 'sinatra/base'
require 'mysql2'
require 'mysql2-cs-bind'
require 'redis'
require 'connection_pool'

class InitRedis
  def config
    @config ||= {
      db: {
        host: ENV['ISHOCON1_DB_HOST'] || 'localhost',
        port: ENV['ISHOCON1_DB_PORT'] && ENV['ISHOCON1_DB_PORT'].to_i,
        username: ENV['ISHOCON1_DB_USER'] || 'ishocon',
        password: ENV['ISHOCON1_DB_PASSWORD'] || 'ishocon',
        database: ENV['ISHOCON1_DB_NAME'] || 'ishocon1'
      }
    }
  end

  def db
    return Thread.current[:ishocon1_db] if Thread.current[:ishocon1_db]
    client = Mysql2::Client.new(
      host: config[:db][:host],
      port: config[:db][:port],
      username: config[:db][:username],
      password: config[:db][:password],
      database: config[:db][:database],
      reconnect: true
    )
    client.query_options.merge!(symbolize_keys: true)
    Thread.current[:ishocon1_db] = client
    client
  end

  def redis
    @redis ||= ConnectionPool::Wrapper.new do
      Redis.new(url: 'redis://localhost:6379/0')
    end
  end

  def init_redis
    redis.flushall

    products = db.xquery('SELECT p.id, p.name, p.description, p.image_path, p.price FROM products as p')
    products.each do |product|
      redis.hset("products", product[:id], product.to_json)
    end
  end
end

InitRedis.new.init_redis

puts InitRedis.new.redis.hget("products", 1)
