require 'sinatra'
require 'haml'

set :haml, :format => :html5

get '/' do
  haml :index, :locals => {:articles => articles}
end

get '/articles' do
  from = params['from'].try(:to_i)
  haml :articles, :locals => {:articles => articles(from)}
end

def articles(from = Article.latest_nr)
  Article.order_by([:nr,:desc]).where(:nr.lte => from).limit(20)
end
