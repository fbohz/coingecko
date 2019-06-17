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
    puts "Which coin would you like to check? For the main menu please type menu"
    @input = gets.strip.downcase 
    #@input
    
    self.check_selection
  end 
  
  def input
    @input
  end 
  
  def main_menu
    puts "\n-To list the top 20 coins type ls."
    puts "-For a list of ALL coins please type all"
    puts "-To QUIT: please type q."

    self.selection
  end 
  
  def list
      
     puts "listing coins...tbd"
     #list coins.  

    self.selection
  end
  
  def list_all
      
     puts "listing ALL coins...tbd"
     #list coins.  

    self.selection
  end
  
  def check_selection 
      case input
      when "ls", "list"
        self.list
      when "menu", "m"
        self.main_menu
      when "q", "quit", "exit", "exit!"
        self.quit  
        
      # need logic ike when input.include? blblabla check if it exists  
    else   
      puts "omg"
      selection
    end
  end  
    
  def quit
    puts "Goodbye! See you next time"
    sleep 1
    # system('clear') 
  end   
    
  
end   
