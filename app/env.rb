require 'mongoid'

Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db("allsofterworlds")
end

Dir.glob(File.dirname(__FILE__) + '/models/*.rb') { |f| require f }

