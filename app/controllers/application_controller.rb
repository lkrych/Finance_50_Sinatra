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
        @user = current_user
        @user_stock = current_stocks(@user)
        if !@user_stock.nil? 
            update_prices(@user_stock)
        end
        @bank = usd(@user.bank)
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
    @user = current_user
    stock = lookup(params[:symbol])
    @symbol = stock[:symbol]
    @price = stock[:ask].to_f 
    @name = stock[:name]
    @shares = params[:shares].to_i
    @total = (@price * @shares).to_f.round(2)
    if @user.bank > @total
        #update already owned stock
        if Stock.exists?(:user => @user.id, :symbol => @symbol)
            owned_stock = Stock.find_by user: @user.id, symbol: @symbol
            @new_shares = owned_stock.shares + @shares
            owned_stock.update(shares: @new_shares)
        else #create new stock
            Stock.create(symbol: @symbol, name: @name, shares: @shares, price: @price, user: @user.id)
        end
        #update users bank
        bank_update = @user.bank - @total
        @user.update_attribute(:bank, bank_update)
    else
        flash[:notice] = "I'm sorry, but you do not have enough money in the bank to buy that stock."
    end
    
    redirect 'users/home'
end

get '/sell' do
    haml :'stocks/sell'
end

post '/sell' do
    @user = current_user
    @symbol = params[:symbol]
    if Stock.exists?(:user => @user.id, :symbol => @symbol)
            owned_stock = Stock.find_by user: @user.id, symbol: @symbol
            bank_update = @user.bank + (owned_stock.shares * owned_stock.price)
            @user.update_attribute(:bank, bank_update)
            owned_stock.delete
    else #create new stock
            flash.now[:notice] = "I'm sorry, but you don't own that stock"
    end
    
    redirect 'users/home'
end


#clear threads
after do
  ActiveRecord::Base.clear_active_connections!
end