class User < ApplicationRecord
	has_many :user_cards, dependent: :destroy
	has_many :cards, through: :user_cards
	
	has_many :user_comments, dependent: :destroy
	has_many :comments, through: :user_comments
end
