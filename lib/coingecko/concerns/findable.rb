module Concerns
  module Findable
   def find_by_name(input)
     Coingecko::Global.get_all_coins_list
     Coingecko::Global.all_coins_list.detect {|coin| coin.name.strip.downcase == input }
   end

    def guess_by_name(input)
      Coingecko::Global.get_all_coins_list
      Coingecko::Global.all_coins_list.filter {|coin| coin.name.strip.downcase.include? input }
   end
 end
end