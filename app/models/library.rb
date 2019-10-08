class Library < ApplicationRecord
  has_many :librarians, :through => :librarians
  belongs_to :university, :foreign_key => :university_id
  validates :max_days, :presence =>true, :numericality => {only_integer: true}
  validates :fines, :presence => true, :numericality =>true
  validates :location, :presence => true
end
