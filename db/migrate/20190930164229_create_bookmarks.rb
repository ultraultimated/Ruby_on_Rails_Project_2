class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.integer :student_id
      t.string :ISBN

      t.timestamps
    end
  end
end
