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
  
  def decimal_separator(number) #Helper Method. Separates numbers with decimals or returns ∞ when NaN.
     if number.is_a? Numeric
        whole, decimal = number.to_s.split(".")
        whole_with_commas = whole.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
        [whole_with_commas, decimal].compact.join(".")
    else 
      number = "∞"
      number
    end 
  end 
  
  def print_coin(id, currency="usd")
    coin = Coingecko::Coin.get_coin(id)
    rows = []
    rows << [ "\n\n----------- #{coin.name}(#{coin.symbol}) - Real-Time Rank##{coin.market_cap_rank} ------------"]
    sleep 0
    rows << [ "\n\nCurrent Price: $#{decimal_separator(coin.market_data["current_price"][currency])} | Market Cap: $#{decimal_separator(coin.market_data["market_cap"][currency])}"]
    rows << [ "24hr Trading Vol: $#{decimal_separator(coin.market_data["total_volume"][currency])}"]
    rows << [ "\n\nAvailable Supply: #{decimal_separator(coin.market_data["total_supply"])} / #{decimal_separator(coin.market_data["circulating_supply"])}\n\n" ]
    table1 = Terminal::Table.new :rows => rows
    puts table1
    sleep 0
    puts  "\n\nDescription:\n\n"
    puts  coin.description["en"].gsub(/<\/?[^>]*>/, "") #.gsub strips HTML tags
    puts "\n\n-------------Quick Facts------------\n\n"
    rows_two = []
    rows_two << ["Percentage Change: \n(7 Days) =>  (30 Days) => (1 Year)"]
    rows_two << [ "#{coin.market_data["price_change_percentage_7d_in_currency"][currency].round(1)}%   =>  #{coin.market_data["price_change_percentage_30d_in_currency"][currency].round(1)}%  =>  #{coin.market_data["price_change_percentage_1y_in_currency"][currency].round(1)}%  "] 
    rows_two << [ "\n\nAll-Time High | ATH Date | Since ATH "]
    rows_two << [" #{coin.market_data["ath"][currency]}  | #{coin.market_data["ath_date"][currency][0..9]}  | #{coin.market_data["ath_change_percentage"][currency].round(1)}  %"]
    table2 = Terminal::Table.new :rows => rows_two
    puts table2
    puts "\n\n      Website             |           Reddit            |                 Github               | Twitter Handle	"
    puts "#{coin.links["homepage"][0]} | #{coin.links["subreddit_url"]} |  #{coin.links["repos_url"]["github"][0]} | #{coin.links["twitter_screen_name"]} "
    rows_three = []  
    rows_three << [ "Genesis Date: #{coin.genesis_date}"]
    rows_three << ["\nLast Updated: #{coin.last_updated}"]
    sleep 0
    table3 = Terminal::Table.new :rows => rows_three
    puts table3

    #binding.pry
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
