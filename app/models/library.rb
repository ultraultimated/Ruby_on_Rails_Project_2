class Library < ApplicationRecord
  has_many :librarians, :through => :librarians
  has_many :books 
  belongs_to :university, :foreign_key => :university_id
  validates :max_days,  :presence =>true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :fines, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :location, :presence => true

end
