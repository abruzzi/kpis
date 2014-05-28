require 'sinatra'
require 'json'

set :bind, "0.0.0.0"

get '/kpi/:type' do
    kpi = File.read(File.open("data/#{params[:type]}.json"))
    erb :index, :locals => {:kpi => kpi}
end
