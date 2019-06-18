class Coingecko::API
  attr_accessor :endpoint
  
  def self.api_call(endpoint="coins")
    #defaults to list coins
    @endpoint = endpoint
    res = open("https://api.coingecko.com/api/v3/#{endpoint}").read 
    @json = JSON.parse(res)
    #puts @json.class
    
  end
  
  # def json 
  #   @json
  # end 
  
  def self.find_coin(query) #needs refactor, get top 50 list first
    #binding.pry
    self.api_call("coins/list")
    coin = []
    @json.each_with_index do |v,k| 
      coin << v if v.fetch("name").include?(query) #needs to refactor this one
    end 
    
    #coin.empty? ? "Your search returned no results, please try again." : coin 
    puts coin
  end 
  
  
end 