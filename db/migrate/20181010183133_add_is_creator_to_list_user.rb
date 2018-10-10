class AddIsCreatorToListUser < ActiveRecord::Migration[5.2]
  def change
    add_column :list_users, :is_creator, :boolean, default: false
  end
end
