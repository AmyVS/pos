require 'active_record'
require './lib/cashier'
require './lib/customer'
require './lib/product'
require './lib/checkout'
require './lib/purchase'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['development'])

@current_cashier = nil
@current_product = nil

def welcome
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

  if Cashier.all.length == 0
    puts "\nNo cashiers listed. Please get a manager."
    manager_menu
  else
    puts Cashier.show_list
    puts 'Please select your number'
    cashier_number = gets.chomp

    @current_cashier = Cashier.all.fetch((cashier_number.to_i)-1) do |number|
      puts "#{number+1} is not a valid choice. Please get a manager."
      manager_menu
    end
    puts "Welcome back, #{@current_cashier.name}!"
    new_patron
  end
end

def new_patron
  puts "\nEnter 'n' to checkout a new patron"
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
  patron = Customer.create
  puts "Customer ID is #{patron.id}"
  cart
end

def cart
  if Product.all.length == 0
    puts "\nNo products available. Please get a manager."
    manager_menu
  else
    puts Product.show_list
    puts "Please enter id number to add a product to patron's cart"
    item = gets.chomp

    @current_product = Product.all.fetch((item.to_i)-1) do |number|
      puts "#{number+1} is not a valid choice. Please try again."
      cart
    end

    puts "Please enter the quantity of that item"
    quantity = gets.chomp
    # stopped here

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

welcome

