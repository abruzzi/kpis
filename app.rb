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

def parse
end

get '/kpi/:type' do
    type = params[:type].downcase

    if(['asr', 'pdpsr'].include? type) 
        kpi2g = JSON.parse(Net::HTTP.get(URI.parse("http://s3.amazonaws.com/kpis/#{type}2g.json")))
        kpi3g = JSON.parse(Net::HTTP.get(URI.parse("http://s3.amazonaws.com/kpis/#{type}3g.json")))

        kpis = {:data => [], 
                :title => [kpi2g["title"], kpi3g["title"]], 
                :target => kpi2g["target"],
                :negativeColor => ["red", "red"],
                :color => ["green", "blue"]
        }
        kpis[:data] << kpi2g["data"]
        kpis[:data] << kpi3g["data"]
    else
        kpis = JSON.parse(Net::HTTP.get(URI.parse("http://s3.amazonaws.com/kpis/#{type}.json")))
    end
    
    erb :index, :locals => {:kpis => kpis.to_json, :type => type}
end

