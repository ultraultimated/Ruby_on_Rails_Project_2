class Library < ApplicationRecord
  has_many :librarians, :through => :librarians
  belongs_to :university, :foreign_key => :university_id
<<<<<<< HEAD
  validates :max_days, :numericality => { :greater_than_or_equal_to => 0 }
  validates :fines, :numericality => { :greater_than_or_equal_to => 0 }
=======
  validates :max_days, :presence =>true, :numericality => {only_integer: true}
  validates :fines, :presence => true, :numericality =>true
  validates :location, :presence => true

>>>>>>> d02422c29aef2089a08ba982b1b7a46af72103e9
end
