require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'pry'

require_relative '../../config/environments' #database configuration
require_relative '../models/user'
require_relative '../models/stock'
require_relative '../helpers/helpers'

enable :sessions #allows use of flash
set :views, '/home/ubuntu/workspace/pset7/finance_sinatra/app/views'
set :public_folder, '/home/ubuntu/workspace/pset7/finance_sinatra/app/public'

get '/' do
    redirect 'sessions/login'
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
    if session[:user_id].nil?
        redirect 'sessions/login'
    else
        @user = User.find_by_id(session[:user_id])
        @user_stock = current_stocks(@user)
        if !@user_stock.nil? 
            update_prices(@user_stock)
            @user_stock.reload
        end
        haml :'users/home'
    end
end

get '/quote' do
    haml :'stocks/quote'
end

post '/quote' do
    stock = lookup(params[:symbol])
    @symbol = stock[:symbol]
    @price = usd(stock[:ask].to_f)
    @name = stock[:name]
    haml :'stocks/quoted'
end

get '/buy' do
    haml :'stocks/buy'
end

post '/buy' do
    @user = User.find_by_id(session[:user_id])
    stock = lookup(params[:symbol])
    @symbol = stock[:symbol]
    @price = stock[:ask].to_f 
    @name = stock[:name]
    @shares = params[:shares].to_i
    @total = (@price * @shares).to_f
    if @user.bank > @total
        # if user has enough money and doesn't own the stock
        current_stock = Stock.where("user = #{@user.id} AND symbol = #{@symbol}")
        if !current_stock.exists?
            Stock.create(symbol: @symbol, name: @name, shares: @shares, price: @price, user: @user.id)
        else #if user has enough money but owns the stock
            owned_stock = Stock.where("user = #{@user.id} AND name = #{@name}")
            @new_shares = owned_stock.shares + @shares
            owned_stock.update(shares: @new_shares)
        end
    @user.bank -= @total
    else
        flash[:notice] = "I'm sorry, but you do not have enough money in the bank to buy that stock."
    end
    haml :'users/home'
end
