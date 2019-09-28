class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :ISBN
      t.string :title, limit: 200
      t.string :author, limit: 70
      t.string :language, limit: 20
      t.string :published, limit: 4
      t.string :edition, limit: 4
      t.string :library, limit: 10
      t.string :image, limit: 500
      t.string :subject, limit: 100
      t.string :summary, limit: 1000
      t.boolean :specialcollection

      t.timestamps
    end
    add_index :books, :ISBN, unique: true
  end
end
