require 'rails_helper'

RSpec.describe Card, type: :model do
	it { should belong_to(:list) }
	it { should have_many(:comments).dependent(:destroy) }
	 
end