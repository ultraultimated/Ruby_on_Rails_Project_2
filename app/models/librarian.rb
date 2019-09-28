class Librarian < ApplicationRecord
  has_secure_password
  belongs_to :library, through: :library_id
  validates :email, :presence => true, :uniqueness => true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :name, :presence => true

end
