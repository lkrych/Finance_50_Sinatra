require 'sinatra'
require 'sinatra/activerecord'
require_relative '../../config/environments' #database configuration
require_relative '../models/user'

class Application < Sinatra::Base

    get '/registrations/signup' do 
        haml 
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
    
end