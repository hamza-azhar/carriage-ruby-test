require 'rails_helper'

RSpec.describe ListUser, type: :model do
	it { should belong_to(:user) }
	it { should belong_to(:list) }
	 

	it "should show error if  same list is already assigned" do
	end
end

	
