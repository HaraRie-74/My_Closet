class CreateClosetComments < ActiveRecord::Migration[6.1]
  def change
    create_table :closet_comments do |t|
      t.string :comment
      t.integer :user_id
      t.integer :closet_id

      t.timestamps
    end
  end
end
