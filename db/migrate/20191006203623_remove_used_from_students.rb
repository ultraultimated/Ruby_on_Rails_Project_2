class RemoveUsedFromStudents < ActiveRecord::Migration[5.2]
  def change
    remove_column :students, :used, :integer
  end
end
