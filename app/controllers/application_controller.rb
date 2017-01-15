require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'

require_relative '../../config/environments' #database configuration
require_relative '../models/user'
#require 'pry'

enable :sessions #allows use of flash
set :views, '/home/ubuntu/workspace/pset7/finance_sinatra/app/views'
set :public_folder, '/home/ubuntu/workspace/pset7/finance_sinatra/app/public'

get '/' do
    haml :'sessions/login'
end

get '/registrations/signup' do 
    flash[:notice]
    haml :'registrations/signup'
end

post '/registrations' do
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])
    if @user.save
        flash[:notice] = "Thanks for signing up #{@user.name}."
        redirect "sessions/login"
    else
        flash[:notice] = "I'm sorry, but your sign up did not work. This is because someone has already used your e-mail address."
        redirect "/registrations/signup"
    end
    
end

get '/sessions/login' do 
    haml :'sessions/login'
end

post '/sessions' do
    @user = User.find_by(email: params["email"])
    if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/users/home"
    else
            flash[:notice] = "I'm sorry, but your sign up did not work. Please try again."
            redirect "/registrations/signup"
    end
end

get '/sessions/logout' do
    session.clear
    redirect '/'
end

get '/users/home' do
    @user = User.find_by_id(session[:user_id])
    haml :'users/home'
end
    
