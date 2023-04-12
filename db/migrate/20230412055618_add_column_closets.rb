class AddColumnClosets < ActiveRecord::Migration[6.1]
  def change
    add_column :closets, :is_published_flag, :boolean, default: true, null:false
  end
end
