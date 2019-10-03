class Rename < ActiveRecord::Migration[5.2]
  def change
    rename_column :universities,
                  :id, :university_id
    rename_column :libraries,
                  :id,:library_id
    rename_column :books,
                  :library, :library_id
    rename_column :librarians,
                :id, :librarian_id
    rename_column :librarians,
                  :library, :library_id
    rename_column :students,
                  :university, :university_id

  end
end
