class CreateRoles < ActiveRecord::Migration

  def migrate(direction)
    super
    # Create a default Roles
    Role.create!([{id: 1 , name: "General Manager"},
                  {id: 2 , name: "Store Manager/ Supervisor"} ,
                  {id: 3 , name: "Cashier"} ,
                  {id: 4 , name: "Customer Service Manager"},
                  {id: 5 , name: "Inventory Manager"},
                  {id: 6 , name: "Warehouse manager"}])
  end

  def change
    create_table :roles do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
