# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# require 'factory_girl'
# Dir[Rails.root.join("spec/factories/*.rb")].each {|f| require f}

# 1.times { FactoryGirl.create :product }
Product.delete_all
Product.create(:id => 1, :title => 'lol', :published => 1, :user_id => 1)
Product.create(:id => 2, :title => 'lol', :published => 1, :user_id => 1)
Product.create(:id => 3, :title => 'lol', :published => 1, :user_id => 1)
Product.create(:id => 4, :title => 'lol', :published => 1, :user_id => 1)