require 'active_record'
require './lib/cashier'
require './lib/customer'
require './lib/product'
require './lib/checkout'
require './lib/purchase'
require 'pry'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['development'])

@running_cost = []
@running_items = []
@current_cashier = nil
@current_product = nil
@current_purchase = nil
@current_checkout = nil

def welcome
  system('clear')
  puts "*" * 40
  puts "Welcome to Vic's Snowboard shop."
  puts "*" * 40
  main_menu
end

def main_menu
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
    exit
  else
    puts "\nSorry, that's not an option. Please try again."
    main_menu
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
  @current_checkout = Checkout.create({:cashier_id => @current_cashier.id, :customer_id => patron.id, :total => nil})
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

    @current_purchase = Purchase.create({:product_id => @current_product.id, :quantity => quantity.to_i, :checkout_id => @current_checkout.id})

    total_item_price = @current_product.price.to_f * quantity.to_i
    @running_cost << total_item_price

    @running_items << @current_product

    puts "Do you want to add more items? y/n"
    choice = gets.chomp
    case choice
    when 'y'
      cart
    when 'n'
      puts "Proceeding to checkout..."
      patron_receipt
    end
  end
end

def manager_menu
  puts "This is a very official menu"
  puts "'c' to add a cashier"
  puts "'p' to add a product"
  puts "'d' to see total daily sales"
  puts "'t' to see total checkouts for a cashier"
  puts "'i' to see the most popular items"
  puts "'m' to see most returned"
  puts "'x' to return to the main menu"

  choice = gets.chomp
  case choice
  when 'c'
    add_cashier
  when 'p'
    add_product
  when 'd'
    total_daily_sales
  when 't'
    total_cashier_checkouts
  when 'i'
    popular_items
  when 'm'
    most_returned
  when 'x'
    puts "Returning to the main menu..."
    main_menu
  else
    puts "Invalid input, please try again."
    manager_menu
  end
end

def patron_receipt
  puts "Receipt"
  @running_items.each do |item|
    puts ("#{item.name}, $#{item.price}")
  end
  final_total = @running_cost.inject(:+)

  @running_items.clear
  @running_cost.clear
  puts "Your total cost is $#{final_total}"
  puts "Thank you! Come again!"


  @current_checkout.update({:total => final_total.to_f})
  new_patron
end

def add_cashier
  puts Cashier.show_list
  puts 'What is the cashier name?'
  name = gets.chomp
  Cashier.create(:name => name)

  puts "Would you like to add another cashier? y/n"
  choice = gets.chomp
  case choice
  when 'y'
    add_cashier
  else
    puts "Returning to the manager menu..."
    manager_menu
  end
end

def add_product
  puts Product.show_list
  puts "What is the name of the product?"
  name = gets.chomp
  puts "What is the price of that product?"
  price = gets.chomp
  Product.create(:name => name, :price => price)

  puts "Would you like to add another product? y/n"
  choice = gets.chomp
  case choice
  when 'y'
    add_product
  else
    puts "Returning to the manager menu..."
    manager_menu
  end
end

def total_cashier_checkouts
  puts Cashier.show_list
  puts 'Please select your number'
  cashier_number = gets.chomp

  @current_cashier = Cashier.all.fetch((cashier_number.to_i)-1) do |number|
    puts "#{number+1} is not a valid choice. Please try again."
    total_cashier_checkouts
  end

  puts "Here's #{@current_cashier.name}'s cashier history:\n"
  @current_cashier.purchases.each_with_index do |purchase, index|
    puts "#{index+1}. #{purchase.product.name} -- quantity: #{purchase.quantity}, price: $#{purchase.product.price}"
  end

  patron_number = Checkout.where({:cashier_id => @current_cashier.id})
  puts "\n\n#{@current_cashier.name} has helped #{patron_number.length} patrons"

  checkouts_by_cashier = Checkout.where({:cashier_id => @current_cashier.id})
  checkouts_by_cashier.each do |checkout|
    puts "Customer# #{checkout.customer_id} -- total: $#{checkout.total}"
  end

  puts "\nWould you like to see another cashier's history? y/n"
  choice = gets.chomp
  case choice
  when 'y'
    total_cashier_checkouts
  else
    puts "Returning to the manager menu..."
    manager_menu
  end
end

welcome
