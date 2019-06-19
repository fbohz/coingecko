class Coingecko::Coin 
 attr_accessor :description, :market_cap_rank, :homepage, :blockchain_site, :reddit, :github_repo, :twitter, :total_supply, :circulating_supply, :genesis_date, :base_currency, :current_price, :ath, :ath_change_percentage, :ath_date, :market_cap, :price_change_24h_in_currency, :price_change_percentage_7d_in_currency, :price_change_percentage_30d_in_currency, :price_change_percentage_1y_in_currency, :last_updated
 attr_reader :id, :trade_symbol, :name, :coin
 
 @@all = []
 @@top_coins = []
 @@coin_extra_attributes = {:description=> nil, :homepage=> nil, :blockchain_site=> nil, :reddit=> nil, :github_repo=> nil, :twitter=> nil, :total_supply=> nil, :circulating_supply=> nil, :genesis_date=> nil, :base_currency=> nil, :current_price=> nil, :ath=> nil, :ath_change_percentage=> nil, :ath_date=> nil, :market_cap=> nil, :price_change_24h_in_currency=> nil, :price_change_percentage_7d_in_currency=> nil, :price_change_percentage_30d_in_currency=> nil, :price_change_percentage_1y_in_currency=> nil}.freeze 
 #@@global_market_cap = nil 
 
  def initialize(id=nil, trade_symbol=nil, name=nil, market_cap_rank=nil, last_updated=nil)
    @id = id 
    @trade_symbol = trade_symbol
    @name = name
    @market_cap_rank = market_cap_rank
    @last_updated = last_updated
    #@@all << self
  end 
  
  def self.create_new_attribute_hash(value_collection)
     new_coin_collection = @@coin_extra_attributes.dup
     
     new_coin_collection.collect do |k, v|
       value_collection.each do |value|
         binding.pry
        new_coin_collection[k] = value
      end 
     end   
   end 
  
  def add_new_coin_attributes(attribute_hash)
    attribute_hash.each {|key, value| self.send("#{key}=", value) }
  end  

 def self.all
   @@all
 end
 
 def self.top_coins
   @@top_coins
 end 
 
 def save
   @@all << self 
 end 
 
 def self.reset(collection)
   collection.clear
 end 
 
 def self.new_from_top_100(currency="usd")
  reset(@@top_coins)
  json = Coingecko::API.list_top_100(currency) 
    json.each do |coin| 
      @@top_coins << self.new(coin["id"], coin["symbol"], coin["name"], coin["market_cap_rank"], coin["last_updated"])
	 end 
 end
 
 def self.get_coin(coin_id, base_currency="usd")
   #attributes = @@coin_attributes.dup
   json = Coingecko::API.look_up_coin(coin_id)
   @coin = self.new(json["id"], json["symbol"], json["name"], json["market_cap_rank"], json["last_updated"])
    #collection = []
    collection = [json["description"]["en"], json["links"]["homepage"], json["links"]["blockchain_site"], json["links"]["subreddit_url"], json["links"]["repos_url"]["github"], json["links"]["twitter_screen_name"], json["market_data"]["total_supply"], json["market_data"]["circulating_supply"], json["genesis_date"], base_currency, json["market_data"]["current_price"][base_currency], json["market_data"]["ath"][base_currency], json["market_data"]["ath_change_percentage"][base_currency], json["market_data"]["ath_date"][base_currency], json["market_data"]["market_cap"][base_currency], json["market_data"]["price_change_24h_in_currency"][base_currency], json["market_data"]["price_change_percentage_7d_in_currency"][base_currency], json["market_data"]["price_change_percentage_30d_in_currency"][base_currency], json["market_data"]["price_change_percentage_1y_in_currency"][base_currency]]
   
   hash = create_new_attribute_hash(collection)
   @coin.add_new_coin_attributes(hash)
   @coin
   
      #json["market_data"]["current_price"]["usd"]  just change usd to base currency to get price. Same with ath
      #json["links"]["homepage"][0] gives the first url (preferred)
  

  # coin.add_attribute(collection)
   
   puts @coin.class
   puts @coin.length
   
       
  # json.each do |k,v| #complete
  #   #binding.pry
  # end 
 # binding.pry
 end  
  
  #COMMENTS_BEGIN
  #current_price and price change calls class method look up to populate those. 
  # the following NEED base_currency:
  # current_price, ath, ath_change_percentage, price_change_24h_in_currency, price_change_percentage_7d_in_currency, price_change_percentage_30d_in_currency, price_change_percentage_1y_in_currency


end   