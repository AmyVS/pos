require 'active_record'
require './lib/cashier'
require './lib/customer'
require './lib/product'
require './lib/checkout'
require './lib/purchase'

ActiveRecord::Base.establish_connection(YAML::load(File.open('.db/config.yml'))['development'])

def Welcome
  system('clear')
  puts "*" * 40
  puts "Welcome to Vic's Snowboard shop."
  puts "*" * 40
  main_menu
end

def main_menu
  choice = nil
  until choice == 'x'

    puts "\n\nWho are you?"

    puts "\nEnter 'm' for manager menu"
    puts "Enter 'c' for cashier menu"
    puts "Enter 'p' for patron menu"
    puts "Enter 'x' to exit"
    choice = gets.chomp

    case choice
    when 'm'
      manager_menu
    when 'c'
      cashier_menu
    when 'p'
      patron_receipt
    when 'x'
      puts "\nHave fun hittin' the slopes!"
    else
      puts "\nSorry, that's not an option. Please try again."
      main_menu
    end
  end
end

def cashier_menu

  puts "\nEnter 'n' to check out a new patron"
  puts "Enter 'x' to exit to the main menu"

  choice = gets.chomp
  case choice
  when 'n'
    checkout_patron
  when 'x'
    main_menu
  else
    puts "\nThat is not a valid option, try again."
    cashier_menu
  end
end

def checkout_patron
  puts "\nDo you have a new customer? y/n"
  choice = gets.chomp

  case choice
  when 'y'
    if Product.all.length == 0
      puts "\nNo products available. Please get a manager."
      manager_menu
    else
      puts Product.show_list
      new_customer = Customer.new
      puts "Please enter id number to add a product to patrons cart"
      item = gets.chomp

      puts "Please enter the quantity of that item"
      quantity = gets.chomp

    end

  when 'n'
    puts "\nNo worries, returning to cashier menu..."
    cashier_menu
  else
    puts "\nThat is not a valid option, try again."
    checkout_patron
  end

end

def manager_menu

end

def patron_receipt

end

