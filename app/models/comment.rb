class Comment < ApplicationRecord
	has_many :replies, class_name: "Comment", foreign_key: "comment_id", dependent: :destroy
 
  belongs_to :comment, class_name: "Comment", optional: true
  belongs_to :card, optional: true

  validates :card_id, presence: true, unless: ->(comment){comment.comment_id.present?}
  validates :comment_id, presence: true, unless: ->(comment){comment.card_id.present?}

  scope :card_comments, ->(card_id) { where(:card_id => card_id) }
  scope :comment_replies, ->(comment_id) { where(:comment_id => comment_id) }
end
