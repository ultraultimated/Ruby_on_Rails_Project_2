class Library < ApplicationRecord
  has_many :librarians, :through => :librarians
  belongs_to :university, :foreign_key => :university_id
end
