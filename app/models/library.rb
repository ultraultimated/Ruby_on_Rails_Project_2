class Library < ApplicationRecord
  has_many :librarians, :through => :librarians
  belongs_to :university, :foreign_key => :university_id
  validates :max_days, :numericality => { :greater_than_or_equal_to => 0 }
  validates :fines, :numericality => { :greater_than_or_equal_to => 0 }
end
