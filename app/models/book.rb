class Book < ApplicationRecord
  belongs_to :library, optional: true
  validates :copies, :presence => true,
            numericality: {only_integer: true, :greater_than_or_equal_to => 1}
  validates :author, :presence => true
  validates :language, :presence => true
  validates :published, :presence => true
  validates :subject, :presence => true
  validates :title, :presence => true
  validates :specialcollection, :presence => true
  validates :ISBN, :presence => true
  def self.up
    change_column :published, :created_at, :datetime
  end

  def self.down
    change_column :published, :created_at, :string
  end
end
