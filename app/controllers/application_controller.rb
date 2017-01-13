require 'sinatra'
require 'sinatra/activerecord'
require_relative '../../config/environments' #database configuration
require_relative '../models/user'
#require 'pry'


set :views, '/home/ubuntu/workspace/pset7/finance_sinatra/app/views'
set :public_folder, '/home/ubuntu/workspace/pset7/finance_sinatra/app/public'

get '/' do
    haml :home
end

get '/registrations/signup' do 
    
end

post '/registrations' do 
end

get '/sessions/login' do 
end

post '/sessions' do
end

get '/sessions/logout' do
end

get '/users/home' do 
end
    
