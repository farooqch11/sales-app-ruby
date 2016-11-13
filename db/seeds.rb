# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

		BusinessType.create!([{name: 'Beauty and Personal Care'} ,
                          {name: 'Casual Use'} ,
                          {name: 'Charities, Education and Membership'} ,
                          {name: 'Food and Drink'} ,
                          {name: 'Health Care and Fitness'} ,
                         	{name: 'Home and Repair'} ,
                          {name: 'Leisure and Entertainment'} ,
                          {name: 'Professional Services'},
                          {name: 'Retail'},
                          {name: 'Transportation'},
													{name: 'Other'}])

    Role.create!([{id: 1 , name: "General Manager"},
                  {id: 2 , name: "Store Manager/ Supervisor"} ,
                  {id: 3 , name: "Cashier"} ,
                  {id: 4 , name: "Customer Service Manager"},
                  {id: 5 , name: "Inventory Manager"},
                  {id: 6 , name: "Warehouse manager"}])

company = User.find_by_email("faizan@faizan.com").company

for i in (1..2000)
  company.users.create(:email => "#{i}Name@Name#{i}.com", role_id: 1 , password: '1234zxcv' , password_confirmation: '1234zxcv' , username: "#{i}Name" )
end

# store = Company.last
# for i in (1..2000)
#   store.item_categories.create(:name => "#{i}Name", :description => "#{i}Description" )
# endAdminAdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')Site.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')