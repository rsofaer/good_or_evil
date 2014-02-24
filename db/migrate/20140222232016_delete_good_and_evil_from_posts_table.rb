class DeleteGoodAndEvilFromPostsTable < ActiveRecord::Migration
  def change
    remove_column :posts, :good
    remove_column :posts, :evil
  end
end
