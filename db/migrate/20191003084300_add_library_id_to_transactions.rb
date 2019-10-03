class AddLibraryIdToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :library_id, :string
  end
end
