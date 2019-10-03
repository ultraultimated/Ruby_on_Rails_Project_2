class RenameToUniversityId < ActiveRecord::Migration[5.2]
  def change
    rename_column :libraries,
                  :university,:university_id
  end
end
