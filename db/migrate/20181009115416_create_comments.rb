class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :content,              :null => false, :default => ""
      t.integer :comment_id

      t.timestamps
    end
  end
end
