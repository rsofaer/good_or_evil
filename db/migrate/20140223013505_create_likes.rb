class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.boolean :good?, default: nil
      # t.boolean :evil, default: false
      # t.integer :likeable_id
      # t.string :likeable_type
      t.belongs_to :likeable, polymorphic: :true
      t.integer :user_id

      t.timestamps
    end
  end
end
