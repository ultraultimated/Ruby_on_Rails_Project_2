require 'rails_helper'
require 'spec_helper'
RSpec.describe Book, type: :model do
  describe 'validations' do
  	describe ' name' do
  		it 'must be present' do
  			Book=described_class.new
  			expect(Book).to_not be_valid
  		end
  	end	
  end
end
