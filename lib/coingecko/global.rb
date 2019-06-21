class Coingecko::Global
  attr_accessor :id, :symbol, :name, :data, :active_cryptocurrencies, :upcoming_icos, :ongoing_icos, :ended_icos, :markets, :total_market_cap, :total_volume, :market_cap_percentage, :market_cap_change_percentage_24h_usd, :updated_at
  @@all_coins_list = []
  
  
  def self.new_from_global
     Coingecko::Global.new.tap do |global_attributes| 
      Coingecko::API.get_global_info.each do |k,v|
           global_attributes.send("#{k}=", v)
        end 
      end 
  end 
  
  def self.all_coins_list
    @@all_coins_list
  end 
  
  def self.get_all_coins_list
     @@all_coins_list.clear
     Coingecko::Global.new.tap do |coin_info| 
      Coingecko::API.get_all_coins.each do |hash_coin|
        hash_coin.each do |k,v|
           coin_info.send("#{k}=", v)
        end 
        @@all_coins_list << coin_info
      end 
    end
  end 
  
end 