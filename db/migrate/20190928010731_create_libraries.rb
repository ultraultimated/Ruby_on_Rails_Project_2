class CreateLibraries < ActiveRecord::Migration[5.2]
  def change
    create_table :libraries do |t|
      t.string :name, limit: 200
      t.string :university, limit: 100
      t.string :location, limit: 300
      t.string :max_days, limit: 10
      t.string :fines, limit: 10

      t.timestamps
    end
  end
end
