class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :company_id , index: true , foreign_key: true
      t.string :attachment
      t.date :start_date
      t.date :end_date
      t.text :purpose
      t.datetime :paid_time
      t.string :type

      t.timestamps null: false
    end
  end
end
