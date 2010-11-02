require 'sinatra'
require 'haml'

set :haml, :format => :html5

get '/' do
  haml :index, :locals => {:articles => Article.order_by([:nr, :desc]).limit(20)}
end

get '/list.json' do
  content_type :json
  Article.all.to_json
end
