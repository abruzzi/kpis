require 'sinatra'
require 'json'

require 'net/http'
require 'uri'

get '/' do
    redirect '/kpi/psr'
end

def load(name)
    File.open(name).read
end

get '/kpi/:type' do
    type = params[:type].downcase
    
    if(['asr', 'pdpsr'].include? type) 
        kpi2g = JSON.parse(load("data/#{type}2g.json"))
        kpi3g = JSON.parse(load("data/#{type}3g.json"))

        kpis = {:data => [], 
                :title => [kpi2g["title"], kpi3g["title"]], 
                :target => kpi2g["target"],
                :negativeColor => ["red", "red"],
                :color => ["green", "blue"]
        }
        kpis[:data] << kpi2g["data"]
        kpis[:data] << kpi3g["data"]

        if kpi2g["reverse"] or kpi3g["reverse"]
            kpis[:negativeColor] = ["green", "blue"]
            kpis[:color] = ["red", "red"]
        end
    else
        kpis = JSON.parse(load("data/#{type}.json"))
        
        kpis[:color] = ["green"]
        kpis[:negativeColor] = ["red"]

        if kpis["reverse"]
            kpis[:color] = ["red"]
            kpis[:negativeColor] = ["green"]
        end
    end
    
    erb :index, :locals => {:kpis => kpis.to_json, :type => type}
end

