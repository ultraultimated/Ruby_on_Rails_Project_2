class Library < ApplicationRecord
  has_many :librarians
  belongs_to :university
end
