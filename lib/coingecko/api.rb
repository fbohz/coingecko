class Coingecko::API
 #attr_accessor :json
  
  # def json 
  #   @json
  # end 
  
  def self.api_call(endpoint="coins")
    #defaults to list coins if no argument passed
    res = open("https://api.coingecko.com/api/v3/#{endpoint}").read 
    @json = JSON.parse(res)
    @json
  end
  

  
  def self.list_top_100(currency="usd")
    self.api_call("coins/markets?vs_currency=#{currency}")
  end   
  
  def self.supported_base
    self.api_call("simple/supported_vs_currencies")
  end   
 
  
  def self.find_coin(query) #needs finish 
    #binding.pry
    self.api_call("coins/list")
    coin = []
    @json.each_with_index do |v,k| 
      if v.fetch("name").downcase.include?(query) || v.fetch("name").downcase == query
        coin << v
      end 
    end 
    
    puts coin
  end
  
  def self.look_up_coin(coin_id)
    self.api_call("coins/#{coin_id}?tickers=true&market_data=true&community_data=true&developer_data=true&sparkline=true")
  end 
  
  def self.get_global_info
    self.api_call("global")
  end 
  
  # def self.current_price_and_change(currency="usd")
  #   self.api_call("coins/markets?vs_currency=#{currency}")
  # end 
  
end 