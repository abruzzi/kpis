require 'sinatra'
require 'json'

require 'net/http'
require 'uri'

use Rack::Auth::Basic do |username, password|
    username == 'admin' && password == 'admin'
end

get '/' do
    redirect '/kpi/psr'
end

get '/kpi/:type' do
    kpi = Net::HTTP.get(URI.parse("http://s3.amazonaws.com/kpis/#{params[:type]}.json"))
    erb :index, :locals => {:kpi => kpi, :type => params[:type]}
end

