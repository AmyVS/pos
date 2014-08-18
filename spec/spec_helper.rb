require 'active_record'
require 'rspec'

require 'product'
require 'customer'
require 'cashier'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['test'])

RSpec.configure do |config|
  config.after(:each) do
    Product.all.each { |product| product.destroy }
    Customer.all.each { |customer| customer.destroy }
    Cashier.all.each { |cashier| cashier.destroy }
  end
end
