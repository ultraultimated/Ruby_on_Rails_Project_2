class Hold < ApplicationRecord
	has_many :students
	has_many :books
end
