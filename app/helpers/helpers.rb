require 'yahoo-finance'
require_relative '../models/user'
require_relative '../models/stock'
helpers do
    def current_user(session_hash)
        return User.find_by_id(session_hash[:user_id])
    end
    
    def is_logged_in?(session_hash)
        return current_user.id == session_hash[:user_id]
    end
    
    def lookup(symbol)
        #"Look up quote for symbol."
        
        @data = {}
    
        # reject symbol if it starts with caret
        if symbol.start_with?("^")
            return nil
        end
    
        # reject symbol if it contains comma
        if symbol.include?(",")
            return nil
        end
    
        # query Yahoo for quote
        # http://stackoverflow.com/a/21351911
        begin
            yahoo_client = YahooFinance::Client.new
            @data = yahoo_client.quotes(["#{symbol}"], [:name, :ask, :symbol])
        rescue
            return nil
        end
    
        return @data[0].to_h
    end

    def usd(value)
        #"""Formats value as USD."""
        fmt = "%05.2f" % value
        return "$" + fmt
    end
    
    def update_prices(arr_of_stocks)
        arr_of_stocks.each do |stock|
            current_stock = lookup(stock[:symbol])
            stock.update(price: current_stock[:ask])
        end
        t = Time.now
        date = t.strftime("%m/%d/%Y") 
        time = t.strftime("%I:%M%p")
        flash[:notice] = "The stocks were updated on #{date} at #{time}."
    end
    
    def current_stocks(user)
        return Stock.where(user: user.id)
    end
end