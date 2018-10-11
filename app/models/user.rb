class User < ApplicationRecord
	has_secure_password
	rolify
  
	has_many :user_comments, dependent: :destroy
	has_many :comments, through: :user_comments

	has_many :list_users, dependent: :destroy
	has_many :lists, through: :list_users

	after_create :assign_default_role

	validates :email, :username, uniqueness: true
	validates :email, :username, presence: true

	def assign_default_role
		self.add_role(:member) if self.roles.blank? && self.username != 'Admin'
	end

	def generate_token
    loop do
      token = SecureRandom.hex(10)
      break token unless User.where(access_token: token).exists?
    end
  end

end
