class CreateLibrarians < ActiveRecord::Migration[5.2]
  def change
    create_table :librarians do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :library

      t.timestamps
    end
    add_index :librarians, :email, unique: true
  end
end
