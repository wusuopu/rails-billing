# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.new({:email => "user1@demo.com", :username => 'user1', :password => 'user1', :is_admin => true}).save(validate: false)
User.new({:email => "user2@demo.com", :username => 'user2', :password => 'user2', :is_admin => false}).save(validate: false)

c = Category.create!(name: "餐饮食品", type: Category::TYPE::EXPENSE)
Category.create!(name: "早中晚餐", type: Category::TYPE::EXPENSE, parent: c)
Category.create!(name: "水果", type: Category::TYPE::EXPENSE, parent: c)

c = Category.create!(name: "日常居家", type: Category::TYPE::EXPENSE)
Category.create!(name: "日常用品", type: Category::TYPE::EXPENSE, parent: c)
Category.create!(name: "房租", type: Category::TYPE::EXPENSE, parent: c)

c = Category.create!(name: "其它支出", type: Category::TYPE::EXPENSE)
Category.create!(name: "其它支出", type: Category::TYPE::EXPENSE, parent: c)
