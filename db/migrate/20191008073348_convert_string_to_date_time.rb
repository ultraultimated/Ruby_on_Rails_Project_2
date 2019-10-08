class ConvertStringToDateTime < ActiveRecord::Migration[5.2]
  def change
  	def self.up
    change_column :published, :created_at, :datetime

  end

  def self.down
    change_column :published, :created_at, :string
  end
  end
end
