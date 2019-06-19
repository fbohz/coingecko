class Coingecko::CLI
  @@commands = ["ls", "list", "b", "back", "menu", "m", "q", "quit", "exit", "exit!", "find", "f"]
  
  def run 
    welcome
    sleep 0.5
    selection 
  end 
  
  def welcome 
    puts "\nWelcome to Coingecko! Powered by CoinGecko API.\n\n"
   # binding.pry
  end 
  
  def selection 
    puts "What would you like to do? For the main menu please type menu."
    input = gets.strip.downcase 
    #@input
    
    self.check_selection(input)
  end 
  
  def input
    @input
  end 
  
  def query
    @query
  end  
  
  def main_menu
    puts "\n-To list the top 100 coins type ls."
    puts "-To find a coin by name, type find."
    puts "-To QUIT: please type q."

    self.selection
  end 
  
  def list_top_coins
    #puts "What number of coins would you like to see top 1-20, 20-40, 40-60, 60-80 or 80-100?"
      list = Coingecko::Coin.new_from_top_100
      print_top(list)
  end
  
  # def change_base
  #     puts "\nNote: The default base currency is USD. Would you like to change the base currency?"
  #     query = gets.strip.downcase 
  #       if query == "yes" || query == "y"
  #         need finish...
       
  #     puts "\nHere all the base coins."
  #     base_list = Coingecko::API.supported_base
  #     #call base_list or maybe printer?
  #     puts "\nPlease type the coin you would like to use as a base. To go back type back."
  #     answer = gets.strip.downcase 
  #     if @@commands.include? answer
  #         check_selection(answer)
  #     else     
  #       list_top_coins
  #   end 
  # end   
  
  def check_selection(input) 
      case input
      when "ls", "list"
        list_top_coins
      when "menu", "m", "back", "b"
        self.main_menu
      when "q", "quit", "exit", "exit!"
        self.quit  
      when "find", "f"  
        find
      # NEED logic ike when input.include? blblabla check if it exists  
    else   
      puts "omg"
      selection
    end
  end  
  
  def find 
    puts "Which coin would to find? To go back, please type back."
    @query = gets.strip.downcase 
   
    if @@commands.include? query
      check_selection(query)
    else     
    find_query = Coingecko::API.find_coin(query)
    find_query
   end 
  end 
  
  
  def print_top(list)
    puts "Here are the Top 100 Coins! \n\n"
      sleep 0.5
    #binding.pry
    Coingecko::Coin.top_coins.each_with_index do |coin, index|
    	puts "#{index + 1}. #{coin.name}"
    end 
      sleep 0.5
    puts "\n\nWhich coin would you like to check out? Please type a number 1-100."
    answer = gets.strip.to_i 
    
    if answer.is_a? Numeric
      id = Coingecko::Coin.top_coins[answer - 1].id
      print_coin(id)
    else
      puts "not a number..needs refactor..will quit.."
      quit #remove_me
    end   
  end
  
  def print_coin(id, currency="usd")
    coin = Coingecko::Coin.get_coin(id)
    puts "\n\n----------- #{coin.name}(#{coin.symbol}) - Real-Time Rank##{coin.market_cap_rank} ------------"
    sleep 2
    puts "Current Price: #{coin.market_data["current_price"][currency]}"
    sleep 1
    puts "---------------Description--------------\n\n"
    puts coin.description["en"]
    quit #remove_me
  end 
  
  def quit
    puts "Goodbye! See you next time"
    sleep 1
    # system('clear') 
  end   
    
 #COMMENTS_BEGIN
    #current_price and price change calls class method look up to populate those. 
    # the following NEED base_currency:
    # current_price, ath, ath_change_percentage, price_change_24h_in_currency, price_change_percentage_7d_in_currency, price_change_percentage_30d_in_currency, price_change_percentage_1y_in_currency

  
end   
