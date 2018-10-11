require 'rails_helper'

RSpec.describe User, type: :model do
	it { should have_many(:user_comments).dependent(:destroy) }
	it { should have_many(:comments).through(:user_comments) }

	it { should have_many(:list_users).dependent(:destroy) }
	it { should have_many(:lists).through(:list_users) }

	it { should callback(:assign_default_role).after(:create) }

	it { should validate_uniqueness_of(:username) }
	it { should validate_uniqueness_of(:email) }
	it { should validate_presence_of(:username) }
	it { should validate_presence_of(:email) }
end

	
