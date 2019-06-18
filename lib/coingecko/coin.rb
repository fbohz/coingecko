class Coingecko::Coin 
 attr_accessor :name, :id, :trade_symbol, :description, :market_cap_rank, :homepage, :blockchain_site, :reddit, :github_repo, :twitter, :total_supply, :circulating_supply, :genesis_date, :base_currency, :current_price, :ath, :ath_change_percentage, :ath_date, :market_cap, :price_change_24h_in_currency, :price_change_percentage_7d_in_currency, :price_change_percentage_30d_in_currency, :price_change_percentage_1y_in_currency, :last_updated
 
 @@all = []
 @@top_coins = []
 #@@global_market_cap = nil 
 
 def initialize(id=nil, trade_symbol=nil, name=nil, market_cap_rank=nil, last_updated=nil)
   @id = id 
   @trade_symbol = trade_symbol
   @name = name
   @last_updated = last_updated
   @@all << self
 end 
 
 def self.all
   @@all
 end
 
 def self.top_coins
   @@top_coins
 end 
 
 def reset(collection)
   collection.clear
 end 
 
 def self.new_from_top_100(currency="usd")
  json = Coingecko::API.list_top_100(currency) 
  binding.pry
    json.each do |coin| 
      @@top_coins << self.new(coin["id"], coin["symbol"], coin["name"], coin["market_cap_rank"], coin["last_updated"])
	 end 
 end
  
  #COMMENTS_BEGIN
  #current_price and price change calls class method look up to populate those. 
  # the following NEED base_currency:
  # current_price, ath, ath_change_percentage, price_change_24h_in_currency, price_change_percentage_7d_in_currency, price_change_percentage_30d_in_currency, price_change_percentage_1y_in_currency
  
  ##IMPT Output
      #   [8] pry(Coingecko::API)> json[0].fetch("name")
      # => "Bitcoin"
      # [9] pry(Coingecko::API)> json[0].fetch("id")
      # => "bitcoin"
      # [10] pry(Coingecko::API)> json[0].fetch("symbol")
      # => "btc"
      # [11] pry(Coingecko::API)> json[0].fetch("market_cap_rank")

end   