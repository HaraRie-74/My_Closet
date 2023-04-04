class CreateClosets < ActiveRecord::Migration[6.1]
  def change
    create_table :closets do |t|
      t.integer :user_id
      t.integer :season
      t.date :purchase_date
      t.string :purchase_store
      t.integer :purchase_price
      t.string :memo

      t.timestamps
    end
  end
end
