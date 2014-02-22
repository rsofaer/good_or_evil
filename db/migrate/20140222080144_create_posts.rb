class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :text_overlay
      t.text :photo_link
      t.integer :good
      t.integer :evil

      t.timestamps
    end
  end
end
