class List < ApplicationRecord
	has_many :cards, dependent: :destroy

	has_many :list_users, dependent: :destroy
	has_many :users, through: :list_users

	after_create :save_list_users
	
end
