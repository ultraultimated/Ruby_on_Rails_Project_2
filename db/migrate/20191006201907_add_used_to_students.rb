class AddUsedToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :used, :integer
  end
end
