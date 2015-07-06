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

Bill.create!(type: Category::TYPE::EXPENSE, amount: 10.2, title: '零食', description: '零食小吃', category: c, date: '2015-01-02')
Bill.create!(type: Category::TYPE::EXPENSE, amount: 13.2, title: '零食', description: '零食小吃', category: c, date: '2015-01-12')
Bill.create!(type: Category::TYPE::EXPENSE, amount: 21.5, title: '文具', description: '稿纸', category: c, date: '2015-02-12')
Bill.create!(type: Category::TYPE::EXPENSE, amount: 32.3, title: '家具', description: '桌子', category: c, date: '2015-03-22')
Bill.create!(type: Category::TYPE::EXPENSE, amount: 12.3, title: '', description: '', category: c, date: '2015-03-23')
Bill.create!(type: Category::TYPE::EXPENSE, amount: 36.8, title: '', description: '', category: c, date: '2015-04-21')
Bill.create!(type: Category::TYPE::EXPENSE, amount: 64.9, title: '', description: '', category: c, date: '2015-05-03')
Bill.create!(type: Category::TYPE::EXPENSE, amount: 87.7, title: '', description: '', category: c, date: '2015-06-08')
Bill.create!(type: Category::TYPE::EXPENSE, amount: 19.2, title: '', description: '', category: c, date: '2015-07-04')
Bill.create!(type: Category::TYPE::EXPENSE, amount: 80.4, title: '', description: '', category: c, date: '2015-08-27')
Bill.create!(type: Category::TYPE::EXPENSE, amount: 76.5, title: '', description: '', category: c, date: '2015-09-12')
Bill.create!(type: Category::TYPE::EXPENSE, amount: 95.1, title: '', description: '', category: c, date: '2015-10-14')
Bill.create!(type: Category::TYPE::EXPENSE, amount: 74.0, title: '', description: '', category: c, date: '2015-11-18')
Bill.create!(type: Category::TYPE::EXPENSE, amount: 42.3, title: '', description: '', category: c, date: '2015-12-09')

c = Category.create!(name: "工资", type: Category::TYPE::INCOME)

Bill.create!(type: Category::TYPE::INCOME, amount: 2200.3, title: '', description: '', category: c, date: '2015-03-15')
Bill.create!(type: Category::TYPE::INCOME, amount: 2698.8, title: '', description: '', category: c, date: '2015-04-15')
Bill.create!(type: Category::TYPE::INCOME, amount: 2489.9, title: '', description: '', category: c, date: '2015-05-15')
