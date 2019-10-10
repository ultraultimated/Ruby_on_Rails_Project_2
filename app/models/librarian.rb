class Librarian < ApplicationRecord
  has_secure_password
  belongs_to :library, optional: true
  validates :email, :presence => true, :uniqueness => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :name, :presence => true
  validates :password, :length => {minimum: 8}, allow_nil: true

end
