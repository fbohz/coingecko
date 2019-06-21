class Coingecko::Global
  attr_accessor :data, :active_cryptocurrencies, :upcoming_icos, :ongoing_icos, :ended_icos, :markets, :total_market_cap, :total_volume, :market_cap_percentage, :market_cap_change_percentage_24h_usd, :updated_at
  
  def self.new_from_global
     Coingecko::Global.new.tap do |global_attributes| 
      Coingecko::API.get_global_info.each do |k,v|
           global_attributes.send("#{k}=", v)
        end 
      end 
  end 
  
  
  
end 