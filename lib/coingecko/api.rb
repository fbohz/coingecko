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
  
  
end 