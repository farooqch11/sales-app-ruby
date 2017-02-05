# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  Site.create!(name: 'ManageHub360', email: 'info@managehub360.com', logo: 'logo-white.png') if direction == :up
  if Rails.env.production?
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

    Permission.create!([{id: 1 ,name: 'user_account_and_setting'} ,
                        {id: 2 ,name: 'dashboard_per_location'} ,
                        {id: 3 ,name: 'dashboard_for_all_locations'} ,
                        {id: 4 ,name: 'inventory_management'} ,
                        {id: 5 ,name: 'employee_payroll_management'} ,
                        {id: 6 ,name: 'expenses'},
                        {id: 7 ,name: 'customers_vendors'},
                        {id: 8 ,name: 'social_media_management'},
                        {id: 9 ,name: 'sales_pos'},
                        {id: 10 ,name: 'bank_reconciliations_per_location'},
                        {id: 11 ,name: 'bank_reconciliations_for_all_location'}])
    # modules
    # A. User/account & setting
    # B. Home/Dashboard per location
    # C. Home/Dashboard for all locations
    # D. INVENTORY MANAGEMENT                            =     can_update_items
    # E. Employee/payroll management                     =     can_update_users
    # F. Expenses
    # G. customers/Vendors
    # H. social media management
    # I. SAles/pos                                       =     can_remove_sales
    # J. Bank reconciliations per location
    # K. Bank reconciliations for all locations

    # Role Number 1: General Manager (A, B, C, D, E, F, G,H, I, J,K)
    # Role Number 2: Store Manager/ Supervisor    (B,E,F,J,D,I)
    # Role Number 3: Cashier (managing the POS for location assigned) (I,J)
    # Role Number 4: Customer Service Manager (G,H)
    # Role Number 5: Inventory Manager (D,F)
    # Role Number 6: Warehouse manager: (D&F for All the materials across all locations)

    [1,2,3,4,5,6,7,8,9,10,11].each{ |key| Permission.find(key).roles << Role.general_manager}
    [2,5,6,7,10,11].each{ |key| Permission.find(key).roles << Role.store_manager}
    [9,10].each{ |key| Permission.find(key).roles << Role.cashier}
    [7,8].each{ |key| Permission.find(key).roles << Role.customer_service_manager}
    [4,6].each{ |key| Permission.find(key).roles << Role.inventory_manager}
    [4,6].each{ |key| Permission.find(key).roles << Role.warehouse_manager}
  end
    if Rails.env.development?
      100.times do
        ItemCategory.create({company_id: 2 , name: Faker::Commerce.department , description: Faker::Lorem.paragraph })
      end
      30.times do
        Item.create({location_id: 2 , photo: Faker::Avatar.image("my-own-slug", "50x50") , stock_amount: Faker::Number.between(1, 200) ,description: Faker::Lorem.paragraph , sku: Faker::Code.ean,cost_price: Faker::Commerce.price , item_category_id: Company.find(2).item_categories.sample, company_id: 2 ,name: Faker::Commerce.product_name, price: Faker::Commerce.price})
      end
    end


# company = User.find_by_email("faizan@faizan.com").company
#
# for i in (1..2000)
#   company.users.create(:email => "#{i}Name@Name#{i}.com", role_id: 1 , password: '1234zxcv' , password_confirmation: '1234zxcv' , username: "#{i}Name" )
# end

# store = Company.last
# for i in (1..2000)
#   store.item_categories.create(:name => "#{i}Name", :description => "#{i}Description" )
# endAdminAdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')Site.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')