class Comment < ApplicationRecord
	has_many :replies, class_name: "Comment", foreign_key: "replier_id", dependent: :destroy
 
  belongs_to :comment, class_name: "Comment"
  belongs_to :card
end
