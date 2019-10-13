require 'rails_helper'

RSpec.describe Book, type: :model do
  it "isbn invalid" do
    book = Book.new(isbn: nil)
    expect(book).to_not be_valid
  end
  it "summary invalid" do
    book = Book.new(summary: nil)
    expect(book).to_not be_valid
  end
  it "title invalid" do
    book = Book.new(title: nil)
    expect(book).to_not be_valid
  end
  
end
  
