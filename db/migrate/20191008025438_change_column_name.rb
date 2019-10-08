class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :books, :image, :avatar
  end
end
