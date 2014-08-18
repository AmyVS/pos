require 'active_record'
require 'shoulda-matchers'
require 'rspec'

require 'product'
require 'customer'
require 'cashier'
require 'purchase'
require 'checkout'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['test'])

RSpec.configure do |config|
  config.before(:each) do
    Product.all.each { |product| product.destroy }
    Customer.all.each { |customer| customer.destroy }
    Cashier.all.each { |cashier| cashier.destroy }
    Checkout.all.each { |checkout| checkout.destroy }
    Purchase.all.each { |purchase| purchase.destroy }
  end
end
