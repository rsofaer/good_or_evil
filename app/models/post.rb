class Post < ActiveRecord::Base
  belongs_to :user
  mount_uploader :photo, PhotoUploader
  paginates_per 6
  has_many :comments
  has_many :likes, as: :likeable, dependent: :destroy

end
