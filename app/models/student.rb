require 'bcrypt'
class Student < ApplicationRecord
  has_secure_password
  belongs_to :university, optional:  true
  belongs_to :hold, optional: true
  
  #attr_accessor :email, :name, :password, :password_confirmation, :educational_level, :university, :maximum_books
  validates :email, :presence => true, :uniqueness => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :educational_level,  :presence =>true
  validates :university_id,  :presence =>true
  validates :name, :presence => true
  validates :password, :length => {minimum: 8}, allow_nil: true
  #validates :maximum_books, :presence => true, :length => {:in =>  1..1}
  
end
