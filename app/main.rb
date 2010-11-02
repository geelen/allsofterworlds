require 'sinatra'

get '/' do
  "Hello World!"
end

get '/list' do
  Article.all.to_a.inspect
end
