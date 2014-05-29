require 'sinatra'
require 'json'

require 'net/http'
require 'uri'

require './lib/kpi'

set :bind, "0.0.0.0"


use Rack::Auth::Basic do |username, password|
    username == 'admin' && password == 'admin'
end

get '/' do
    redirect '/kpi/psr'
end

get '/kpi/:type' do
    kpi = Net::HTTP.get(URI.parse("https://s3.amazonaws.com/kpis/#{params[:type]}.json"))
    erb :index, :locals => {:kpi => kpi, :type => params[:type]}
end

