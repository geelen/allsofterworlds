require 'sinatra'
require 'haml'

set :haml, :format => :html5

get '/' do
  redirect '/asofterworld'
end

get '/:site' do
  haml :index, :locals => {:articles => articles(params[:site])}
end

get '/:site/articles' do
  haml :articles, :locals => {:articles => articles(params[:site], params['from'].try(:to_i))}
end

def articles(site, from = nil)
  from ||= 1
  Article.where(:site => site).order_by([:nr,:asc]).where(:nr.gte => from).limit(5)
end
