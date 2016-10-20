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

store = Company.last
for i in (1..2000)
  store.item_categories.create(:name => "#{i}Name", :description => "#{i}Description" )
end