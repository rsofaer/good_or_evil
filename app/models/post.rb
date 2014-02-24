class Post < ActiveRecord::Base
  belongs_to :user
  mount_uploader :photo, PhotoUploader
  has_many :comments
  has_many :likes, as: :likeable, dependent: :destroy

end
