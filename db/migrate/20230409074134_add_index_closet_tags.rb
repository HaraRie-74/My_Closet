class AddIndexClosetTags < ActiveRecord::Migration[6.1]
  def change
    # 同じタグを２回保存することを出来ないようにする
    add_index :closet_tags, [:closet_id, :tag_id], unique: true
  end
end
