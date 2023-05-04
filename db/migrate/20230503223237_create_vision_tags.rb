class CreateVisionTags < ActiveRecord::Migration[6.1]
  def change
    create_table :vision_tags do |t|
      t.string :vision_tag_name
      t.integer :closet_id

      t.timestamps
    end
  end
end
