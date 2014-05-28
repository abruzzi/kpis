require 'sinatra'
require 'json'

set :bind, "0.0.0.0"

get '/' do
    redirect '/kpi/psr'
end

get '/kpi/:type' do
    kpi = File.read(File.open("data/#{params[:type]}.json"))
    erb :index, :locals => {:kpi => kpi, :type => params[:type]}
end

get '/admin' do
    now = Time.now.strftime("%m/%d/%Y")
    erb :admin, :locals => {:today => now}
end

get '/upload' do
    erb :upload
end

post '/uploadkpi' do
  unless params[:file] &&
         (tmpfile = params[:file][:tempfile]) &&
         (name = params[:file][:filename])
      halt
  end

  str = ""
  while blk = tmpfile.read(4096)
    str += blk
  end

  File.open("data/#{name}", 'w') do |f|
      f.write(str)
  end

  type = name.chomp(File.extname(name))
  redirect "/kpi/#{type}"
end

post '/updatefig' do
    date = params[:date]
    psr = params[:psr]
    ccr = params[:ccr]
    lusr = params[:lusr]
    asr2g = params[:asr2g]
    asr3g = params[:asr3g]
    pdpsr2g = params[:pdpsr2g]
    pdpsr3g = params[:pdpsr3g]
    hosr = params[:hosr]
    ccsrcs = params[:ccsrcs]
    ccsrps = params[:ccsrps]

    p date, psr
end

