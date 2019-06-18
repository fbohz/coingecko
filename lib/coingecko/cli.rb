class Coingecko::CLI
  
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
    @input = gets.strip.downcase 
    #@input
    
    self.check_selection
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
    puts "What number of coins would you like to see top 1-20, 20-40, 40-60, 60-80 or 80-100?"
    puts "\nNote: The default base currency is USD. If you like to change it type change"
    query = gets.strip.downcase 
      if query == "change" || query == "c"
          change_base
      else     
          list = Coingecko::API.list_top_100
          puts "listing coins...tbd..need printer to pass list object"
          self.selection
     end 
      
  end
  
  def change_base
       puts "\nHere all the base coins."
       base_list = Coingecko::API.supported_base
       #call base_list or maybe printer?
       puts "\nPlease type the coin you would like to use as a base. To go back type back."
       answer = gets.strip.downcase 
       if answer == "b" || answer == "back"
          list_top_coins
      else     
          list = Coingecko::API.list_top_100(answer)
          puts "listing coins...tbd..need printer to pass list object"
          self.selection
     end 
  end   
  
  def check_selection 
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
   
    if query == "back" || query == "b"
      self.selection
    else     
    find_query = Coingecko::API.find_coin(query)
    find_query
   end 
  end 
  
  
  def printer 
    puts "printing whatever you need..needs refactor."
  end   
  
  def quit
    puts "Goodbye! See you next time"
    sleep 1
    # system('clear') 
  end   
    
  
end   
