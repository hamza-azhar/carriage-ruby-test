require 'rails_helper'

RSpec.describe List, type: :model do
	it { should have_many(:cards).dependent(:destroy) }

	it { should have_many(:list_users).dependent(:destroy) }
	it { should have_many(:users).through(:list_users) }
end

