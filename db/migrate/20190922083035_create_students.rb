class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :educational_level
      t.string :university
      t.string :maximum_book_limit

      t.timestamps
    end
    add_index :students, :email, unique: true
  end
end
