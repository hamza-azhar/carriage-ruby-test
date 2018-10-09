class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :title,              :null => false, :default => ""

      t.timestamps
    end
  end
end
