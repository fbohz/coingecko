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
    puts "\n-To list the top 50 coins type ls."
    puts "-To find a coin by name, type find."
    puts "-To QUIT: please type q."

    self.selection
  end 
  
  def list
      
     puts "listing coins...tbd"
     #list coins.  

    self.selection
  end
  
  def list_all
      
     puts "listing *ALL* coins...tbd"
     #list coins.  

    self.selection
  end
  
  def check_selection 
      case input
      when "ls", "list"
        self.list
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
    
  def quit
    puts "Goodbye! See you next time"
    sleep 1
    # system('clear') 
  end   
    
  
end   
