class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :Books, :avtar, :avatar
  end
end
