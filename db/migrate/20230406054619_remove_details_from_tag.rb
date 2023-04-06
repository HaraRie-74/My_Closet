class RemoveDetailsFromTag < ActiveRecord::Migration[6.1]
  def change
    remove_column :tags, :user_id, :integer
    remove_column :tags, :closet_id, :integer
  end
end
