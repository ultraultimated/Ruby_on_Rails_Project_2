class Student < ApplicationRecord
  has_secure_password
  attr_accessor :email, :name, :password, :educational_level, :university, :maximum_books

  validates :email, :presence => true, :uniqueness => true
  validates :name,  :presence =>true, :length => {:in =>  1..35}
  validates :educational_level,  :presence =>true
  validates :university,  :presence =>true
  validates :maximum_books, :presence => true, :length => {:in =>  1..1}
end
