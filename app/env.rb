require 'mongoid'

Mongoid.configure do |config|
  if RAILS_ENV == 'production'
    config.master = Mongo::Connection.from_uri(ENV['MONGOHQ_URL']).db("allsofterworlds")
  else
    config.master = Mongo::Connection.new.db("allsofterworlds")
  end
end

Dir.glob(File.dirname(__FILE__) + '/models/*.rb') { |f| require f }

