class Coingecko::Coin 
 attr_accessor :id, :symbol, :name, :block_time_in_minutes, :categories, :localization, :description, :links, :image, :country_origin, :genesis_date, :market_cap_rank, :coingecko_rank, :coingecko_score, :developer_score, :community_score, :liquidity_score, :public_interest_score, :market_data, :community_data, :developer_data, :public_interest_stats, :status_updates, :last_updated, :tickers, :current_price, :total_volume, :high_24h, :low_24h, :price_change_24h, :market_cap, :homepage, :blockchain_site, :ath, :ath_change_percentage, :ath_date, :price_change_percentage_24h, :price_change_24h_in_currency, :price_change_percentage_7d_in_currency, :price_change_percentage_30d_in_currency, :price_change_percentage_1y_in_currency, :market_cap_change_24h, :market_cap_change_percentage_24h, :circulating_supply, :total_supply, :sparkline_7d, :roi, :coin, :ico_data, :contract_address
 
 @@all = []
 @@top_coins = []

  def initialize(id=nil, symbol=nil, name=nil, market_cap_rank=nil, last_updated=nil)
    @id = id 
    @symbol = symbol
    @name = name
    @market_cap_rank = market_cap_rank
    @last_updated = last_updated
    #@@all << self
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
   
   def self.get_coin(coin_id)
     Coingecko::Coin.new.tap do |coin| 
      Coingecko::API.look_up_coin(coin_id).each do |k,v|
           coin.send("#{k}=", v)
        end 
        @@all << coin
      end 
    #binding.pry 
   end    

end   