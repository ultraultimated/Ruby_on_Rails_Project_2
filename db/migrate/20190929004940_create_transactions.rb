class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :student_id
      t.string :ISBN
      t.string :bookname
      t.datetime :checkout_date
      t.datetime :expected_date
      t.datetime :return_date
      t.string :status
	  
      t.timestamps
    end
  end
end
