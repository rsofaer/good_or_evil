class SiteController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    gon.post_count = @user.posts.count
    gon.good_like_count = @user.likes.where(good:true).count
    gon.evil_like_count = @user.likes.where(good:false).count
    gon.comment_count = @user.comments.count
    gon.good_like_total = Like.where(good:true).count
  end
  
end
