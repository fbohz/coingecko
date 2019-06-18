class Coingecko::Coin 
 attr_accessor :name, :id, :trade_symbol, :description, :market_cap_rank, :homepage, :blockchain_site, :reddit, :github_repo, :twitter, :total_supply, :circulating_supply, :genesis_date, :base_currency, :current_price, :ath, :ath_change_percentage, :ath_date, :market_cap, :price_change_24h_in_currency, :price_change_percentage_7d_in_currency, :price_change_percentage_30d_in_currency, :price_change_percentage_1y_in_currency
 
 @@all = []
 @@coins = []
 @@global_market_cap = nil 
 
 
  
  
  =begin 
  #current_price and price change calls class method look up to populate those. 
  # the following NEED base_currency:
  # current_price, ath, ath_change_percentage, price_change_24h_in_currency, price_change_percentage_7d_in_currency, price_change_percentage_30d_in_currency, price_change_percentage_1y_in_currency
  =end 
end   