require 'sinatra'
require 'json'

get '/kpi/:type' do
    kpi = File.read(File.open("data/#{params[:type]}.json"))
    erb :index, :locals => {:kpi => kpi}
end
