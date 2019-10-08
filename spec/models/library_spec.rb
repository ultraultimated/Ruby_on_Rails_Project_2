require 'rails_helper'

RSpec.describe Library, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "Associations" do
  it { should belong_to(:university) }
  it { should have_many(:librarians) }
  end
end
