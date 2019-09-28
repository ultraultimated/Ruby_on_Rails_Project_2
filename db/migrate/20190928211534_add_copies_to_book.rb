class AddCopiesToBook < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :copies, :string, limit: 6
  end
end
