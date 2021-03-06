
include Concerns::Findable
class Coingecko::CLI
  @@commands = ["ls", "list", "b", "back", "menu", "m", "q", "quit", "exit", "exit!", "find", "f"]

  def run
    welcome
    sleep 0.5
    selection
  end

  def welcome
    puts "\nWelcome to Coingecko! Powered by CoinGecko API.\n"
  end

  def selection
    puts "\nWhat would you like to do? For the main menu please type menu."
    input = gets.strip.downcase
    self.check_selection(input) #from now on self will be implicit as method receiver.
  end

  def another_selection?
    puts "Would you like make another selection?"
    input = gets.strip.downcase
    if input == "y" || input == "yes"
      main_menu
    elsif input == "n" || input == "no"
      quit
      return
    else
     check_selection(input)
    end
  end


  def main_menu
    puts "\n-To list the top 100 coins type ls."
    puts "-To find a coin by name, type find."
    puts "-To get general info, type gen."
    puts "-To QUIT: please type q."
    sleep 1
    selection
  end

  def list_top_coins
      list = Coingecko::Coin.new_from_top_100
      print_top(list)
  end

  def check_selection(input)
      case input
      when "ls", "list"
        list_top_coins
      when "menu", "m", "back", "b"
        main_menu
      when "q", "quit", "exit", "exit!"
        quit
      when "global", "g", "gen", "general"
        print_global_info
      when "find", "f"
        find
      else
        puts "Sorry! Did not Understand that."
        sleep 1
        puts "Going back.."
        sleep 1
        selection
    end
  end

  def print_top(list)
    puts "Here are the Top 100 Coins!"
      sleep 1.0
    puts ".."
      sleep 1.0
    puts "....\n\n"
      sleep 0.5
    Coingecko::Coin.top_coins.each_with_index do |coin, index|
    	puts "#{index + 1}. #{coin.name}"
    end
      sleep 0.5
    puts "\n\nWhich coin would you like to check out? Please type a number 1-100."
    answer = gets.chomp.to_i

    if answer > 0 #if string converted to_i will have value of 0
      id = Coingecko::Coin.top_coins[answer - 1].id
      print_coin(id)
    else
      check_selection(answer)
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

  def round_if_num(num)
    if num.is_a? Numeric
        num.round(1)
    else
        "Coingecko Returned N/A"
    end
  end

  def table_printer(rows)
    table = Terminal::Table.new :rows => rows
    puts table
  end

  def print_global_info(currency="usd")
    global_info = Coingecko::Global.new_from_global
    rows = []
    puts "Returning Real-Time Global Info from Coingecko..."
      sleep 2
    puts "\nGlobal Info:\n"
      sleep 0.5
      rows << ["Total Cryptocurrencies: #{global_info.data["active_cryptocurrencies"]}"]
      rows << ["Total Market Cap: #{decimal_separator(global_info.data["total_market_cap"][currency])}"]
      rows << ["Total Volume: #{decimal_separator(global_info.data["total_volume"][currency])}"]
    table_printer(rows)
      sleep 2
    rows_two = []
    puts "Market Cap Share (Top 10):\n"
      sleep 1.5
      global_info.data["market_cap_percentage"].each do |k, v|
		    rows_two << ["#{k.upcase}: #{round_if_num(v)}%"]
      end
    table_printer(rows_two)
      sleep 2
    another_selection?
  end

  def find
    puts "Which coin would you like to find?"
    input = gets.chomp.downcase
    coin = find_by_name(input) || guess_by_name(input)
    case
    when coin.class == Coingecko::Global  #found with pry to see what class it is
            sleep 1.5
        puts "\nGreat. '#{input}' coin match found!\n\n"
            sleep 2
        print_coin(coin.id)
    when coin.class == Array && coin.length > 0
            sleep 1.5
        puts "\nNo exact match for '#{input}'. Did you mean?\n\n"
            sleep 2
          coin.each_with_index { |o, i| puts "#{i + 1} - #{o.name}" }
            sleep 1
        print "\nIf one of the coins provided is what you're looking for, please type 1"
        print " - #{coin.length}" if coin.length > 1
        puts " or else type menu to go back.\n\n"
        answer = gets.chomp
           if answer.to_i > 0 #if string converted to_i will have value of 0
            id = coin[answer.to_i - 1].id
            print_coin(id)
          else
            check_selection(answer)
          end
    else
            sleep 1
        puts "\nSorry. We didn't find '#{input}'.\n\n"
            sleep 2
        another_selection?

    end
  end

  def print_coin(id, currency="usd")
    puts "Retrieving your coin."
      sleep 0.5
    puts ".."
      sleep 0.5
    puts "....\n\n"
      sleep 0.5
    coin = Coingecko::Coin.get_coin(id)
    rows = []
      rows << [ "----------- #{coin.name}(#{coin.symbol}) - Rank##{coin.market_cap_rank} (Real-Time) ------------"]
        sleep 2
      rows << [ "\nCurrent Price: $#{decimal_separator(coin.market_data["current_price"][currency])} | Market Cap: $#{decimal_separator(coin.market_data["market_cap"][currency])}"]
      rows << [ "24hr Trading Vol: $#{decimal_separator(coin.market_data["total_volume"][currency])}"]
      rows << [ "Available Supply: #{decimal_separator(coin.market_data["total_supply"])} / #{decimal_separator(coin.market_data["circulating_supply"])}\n\n" ]
    table_printer(rows)
        sleep 2
      puts  "\nDESCRIPTION:\n"
        sleep 2
      puts  coin.description["en"].gsub(/<\/?[^>]*>/, "") #.gsub strips HTML tags
        sleep 2
      puts "\n----------------QUICK FACTS---------------\n"
        sleep 1
      rows_two = []
      rows_two << ["Percentage Change: \n(7 Days) =>(30 Days) =>(1 Year)"]
      rows_two << [ "#{round_if_num(coin.market_data["price_change_percentage_7d_in_currency"][currency])}%        #{round_if_num(coin.market_data["price_change_percentage_30d_in_currency"][currency])}%      #{round_if_num(coin.market_data["price_change_percentage_1y_in_currency"][currency])}%  "]
      rows_two << [ "\n\nAll-Time High |  ATH Date  | Since ATH "]
      rows_two << ["#{coin.market_data["ath"][currency]}          #{coin.market_data["ath_date"][currency][0..9]}      #{round_if_num(coin.market_data["ath_change_percentage"][currency])}%"]
    table_printer(rows_two)
    rows_three = []
      rows_three << ["Website: #{coin.links["homepage"][0]}"]
      rows_three << ["Reddit: #{coin.links["subreddit_url"]}"]
      rows_three << ["Github: #{coin.links["repos_url"]["github"][0]} "]
      rows_three << ["Twitter Handle: @#{coin.links["twitter_screen_name"]}"]
      rows_three << ["Genesis Date: #{coin.genesis_date}"] if coin.genesis_date
      rows_three << ["Last Updated: #{coin.last_updated[0..9]}"]
        sleep 2
    table_printer(rows_three)
        sleep 2
    another_selection?
  end

  def quit
    sleep 0.5
    puts "\nGoodbye! See you next time."
    sleep 1
    system('clear')
  end

  #FOR FUTURE Feature
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

 # Change Base COMMENTS_BEGIN
    #current_price and price change calls class method look up to populate those.
    # the following NEED base_currency:
    # current_price, ath, ath_change_percentage, price_change_24h_in_currency, price_change_percentage_7d_in_currency, price_change_percentage_30d_in_currency, price_change_percentage_1y_in_currency


end
