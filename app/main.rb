require 'sinatra'
require 'haml'

set :haml, :format => :html5

get '/' do
  haml :index, :locals => {:articles => articles}
end

get '/articles' do
  haml :articles, :locals => {:articles => articles(params['from'].try(:to_i))}
end

def articles(from = nil)
  from ||= Article.latest_nr
  Article.order_by([:nr,:desc]).where(:nr.lte => from).limit(5)
end
