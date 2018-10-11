class ListUser < ApplicationRecord
  belongs_to :user
  belongs_to :list

  validate :validate_list, :on => :create

  def validate_list
  	errors.add(:list_id, "is already assigned to this user") if ListUser.find_by(list_id: self.list_id, user_id: self.user_id).present? 
  end
end
