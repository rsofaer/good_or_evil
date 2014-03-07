class AddUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :aws_url, :text
  end
end
