class CreateClosetTags < ActiveRecord::Migration[6.1]
  def change
    create_table :closet_tags do |t|
      t.integer :closet_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
