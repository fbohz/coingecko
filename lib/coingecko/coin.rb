class Coingecko::Coin 
# attr_accessor :description, :market_cap_rank, :homepage, :blockchain_site, :reddit, :github_repo, :twitter, :total_supply, :circulating_supply, :genesis_date, :base_currency, :current_price, :ath, :ath_change_percentage, :ath_date, :market_cap, :price_change_24h_in_currency, :price_change_percentage_7d_in_currency, :price_change_percentage_30d_in_currency, :price_change_percentage_1y_in_currency, :last_updated
 #attr_reader :id, :symbol, :name, :coin
 
 attr_accessor :id, :symbol, :name, :block_time_in_minutes, :categories, :localization, :description, :links, :image, :country_origin, :genesis_date, :market_cap_rank, :coingecko_rank, :coingecko_score, :developer_score, :community_score, :liquidity_score, :public_interest_score, :market_data, :community_data, :developer_data, :public_interest_stats, :status_updates, :last_updated, :tickers, :current_price, :total_volume, :high_24h, :low_24h, :price_change_24h, :market_cap, :homepage, :blockchain_site, :ath, :ath_change_percentage, :ath_date, :price_change_percentage_24h, :price_change_24h_in_currency, :price_change_percentage_7d_in_currency, :price_change_percentage_30d_in_currency, :price_change_percentage_1y_in_currency, :market_cap_change_24h, :market_cap_change_percentage_24h, :circulating_supply, :total_supply, :sparkline_7d, :roi
 
 @@all = []
 @@top_coins = []
# @@coin_extra_attributes = {:description=> nil, :homepage=> nil, :blockchain_site=> nil, :reddit=> nil, :github_repo=> nil, :twitter=> nil, :total_supply=> nil, :circulating_supply=> nil, :genesis_date=> nil, :base_currency=> nil, :current_price=> nil, :ath=> nil, :ath_change_percentage=> nil, :ath_date=> nil, :market_cap=> nil, :price_change_24h_in_currency=> nil, :price_change_percentage_7d_in_currency=> nil, :price_change_percentage_30d_in_currency=> nil, :price_change_percentage_1y_in_currency=> nil}.freeze 
 #@@global_market_cap = nil 
 
  # def initialize(id=nil, trade_symbol=nil, name=nil, market_cap_rank=nil, last_updated=nil)
  #   @id = id 
  #   @trade_symbol = trade_symbol
  #   @name = name
  #   @market_cap_rank = market_cap_rank
  #   @last_updated = last_updated
  #   #@@all << self
  # end 
  
  # def self.create_new_attribute_hash(value_collection)
  #   new_coin_collection = @@coin_extra_attributes.dup
     
  #   new_coin_collection.collect do |k, v|
  #     value_collection.each do |value|
  #       binding.pry
  #       new_coin_collection[k] = value
  #     end 
  #   end   
  # end 
  
  # def add_new_coin_attributes(attribute_hash)
  #   attribute_hash.each {|key, value| self.send("#{key}=", value) }
  # end  
  
 def initialize(coingecko_json=nil)
    if coingecko_json
      coingecko_json.each do |hashes|
        hashes.each do |k,v|
         # binding.pry
         self.send("#{k}=", v)
        end 
      end
    end  
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
      @@top_coins << self.new(json)
	 end 
  
 end
 
 #PREVIOUS ONE
#   def self.new_from_top_100(currency="usd")
#   reset(@@top_coins)
#   json = Coingecko::API.list_top_100(currency) 
#     json.each do |coin| 
#       @@top_coins << self.new(coin["id"], coin["symbol"], coin["name"], coin["market_cap_rank"], coin["last_updated"])
# 	 end 
# end
 
 def self.get_coin(coin_id, base_currency="usd")
   #attributes = @@coin_attributes.dup
   json = Coingecko::API.look_up_coin(coin_id)
   @coin = self.new_from_json(json)
    
    #IF it works you will print like this..
    # collection = [coin["description"]["en"], coin["links"]["homepage"], coin["links"]["blockchain_site"], coin["links"]["subreddit_url"], coin["links"]["repos_url"]["github"], coin["links"]["twitter_screen_name"], coin["market_data"]["total_supply"], coin["market_data"]["circulating_supply"], coin["genesis_date"], base_currency, coin["market_data"]["current_price"][base_currency], coin["market_data"]["ath"][base_currency], coin["market_data"]["ath_change_percentage"][base_currency], coin["market_data"]["ath_date"][base_currency], coin["market_data"]["market_cap"][base_currency], coin["market_data"]["price_change_24h_in_currency"][base_currency], coin["market_data"]["price_change_percentage_7d_in_currency"][base_currency], coin["market_data"]["price_change_percentage_30d_in_currency"][base_currency], coin["market_data"]["price_change_percentage_1y_in_currency"][base_currency]]
   
   @coin
   
   puts @coin.class
   puts @coin.length
   
 end  
  
  #COMMENTS_BEGIN
  #current_price and price change calls class method look up to populate those. 
  # the following NEED base_currency:
  # current_price, ath, ath_change_percentage, price_change_24h_in_currency, price_change_percentage_7d_in_currency, price_change_percentage_30d_in_currency, price_change_percentage_1y_in_currency


end   