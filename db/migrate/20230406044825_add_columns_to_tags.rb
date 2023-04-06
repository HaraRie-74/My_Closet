class AddColumnsToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :user_id, :integer
    add_column :tags, :closet_id, :integer
  end
end
