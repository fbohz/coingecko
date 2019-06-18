class Coingecko::API
 # attr_accessor :endpoint
  
  def self.api_call(endpoint="coins")
    #defaults to list coins if no argument passed
    #@endpoint = endpoint
    res = open("https://api.coingecko.com/api/v3/#{endpoint}").read 
    @json = JSON.parse(res)
    
  end
  
  def self.list_top_100(currency="usd")
    #@currency = currency
    self.api_call("coins/markets?vs_currency=#{currency}")
    
  end   
  
  def self.supported_base
    self.api_call("simple/supported_vs_currencies")
  end   
 
  
  def self.find_coin(query) #needs finish so it lets user select then sends it to main page BUT get top 50 list first
    #binding.pry
    self.api_call("coins/list")
    coin = []
    @json.each_with_index do |v,k| 
      if v.fetch("name").downcase.include?(query) || v.fetch("name").downcase == query
        coin << v
      end 
    end 
    
    #coin.empty? ? "Your search returned no results, please try again." : coin 
    puts coin
  end
  
  def self.look_up_coin(coin_name)
   #@coin_name = coin_name
    self.api_call("coins/#{coin_name}?tickers=true&market_data=true&community_data=true&developer_data=true&sparkline=true")
  end 
  
  # def self.current_price_and_change(currency="usd")
  #   self.api_call("coins/markets?vs_currency=#{currency}")
  # end 
  
end 