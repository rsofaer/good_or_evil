class Post < ActiveRecord::Base
  belongs_to :user
  mount_uploader :photo, PhotoUploader
  paginates_per 12
  has_many :comments
  has_many :likes, as: :likeable, dependent: :destroy
  #the model shouldn't have that validate length max method, it does
  #weird things if it is in there.
end
