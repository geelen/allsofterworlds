require 'sinatra'
require 'haml'

set :haml, :format => :html5

get '/' do
  haml :index, :locals => {:articles => Article.order_by([:nr, :desc]).limit(20)}
end

get '/articles.json' do
  content_type :json

  from = params['from'].try(:to_i) || Article.latest_nr
  Article.order_by([:nr,:desc]).where(:nr.lte => from).limit(20).to_json
end
