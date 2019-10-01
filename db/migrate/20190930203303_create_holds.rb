class CreateHolds < ActiveRecord::Migration[5.2]
  def change
    create_table :holds do |t|
      t.integer :student_id
      t.string :ISBN
      t.string :library_id

      t.timestamps
    end
  end
end
