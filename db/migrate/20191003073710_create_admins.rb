class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :name, limit: 200
      t.string :email, limit: 200
      t.string :password_digest

      t.timestamps
    end
  end
end
