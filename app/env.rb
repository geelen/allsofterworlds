require 'mongoid'

Mongoid.configure do |config|
  if ENV['RAILS_ENV'] == 'production'
    require 'uri'
    config.master = Mongo::Connection.from_uri(ENV['MONGOHQ_URL']).db(URI.parse(ENV['MONGOHQ_URL']).path.gsub(/^\//, ''))
  else
    config.master = Mongo::Connection.new.db("allsofterworlds")
  end
end

Dir.glob(File.dirname(__FILE__) + '/models/*.rb') { |f| require f }

