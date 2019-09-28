class AddIsValidToLibrarian < ActiveRecord::Migration[5.2]
  def change
    add_column :librarians, :is_valid, :boolean
  end
end
