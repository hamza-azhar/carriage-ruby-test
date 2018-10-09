class User < ApplicationRecord
	has_secure_password
	rolify
	has_many :user_cards, dependent: :destroy
	has_many :cards, through: :user_cards
	
	has_many :user_comments, dependent: :destroy
	has_many :comments, through: :user_comments

	after_create :assign_default_role

	validates :email, :username, uniqueness: true
	validates :email, :username, presence: true

	def assign_default_role
  		self.add_role(:member) if self.roles.blank?
  	end

end
