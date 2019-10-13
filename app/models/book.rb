class Book < ApplicationRecord
  has_many_attached :avatar

  mount_uploader :avatar, ImageUploader
  belongs_to :library, optional: true
  belongs_to :bookmark, optional: true
  belongs_to :hold, optional: true
  validates :copies, :presence => true,
            numericality: {only_integer: true, :greater_than_or_equal_to => 1}
  validates :author, :presence => true
  validates :language, :presence => true
  validates :published, :presence => true, :numericality => true
  validates :subject, :presence => true
  validates :title, :presence => true
  validates :specialcollection, :presence => true
  validates :ISBN, :presence => true, :numericality => true,
            length: {minimum: 13, maximum: 13}, :uniqueness => true
  def self.up
    change_column :published, :created_at, :datetime
  end

  def self.down
    change_column :published, :created_at, :string
  end
end
