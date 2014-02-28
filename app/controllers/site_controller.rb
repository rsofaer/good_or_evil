class SiteController < ApplicationController
      
  def index
    gon.clear
    # if current_user
    #   if current_user.nil?
    #     redirect_to root_path
    #   else
    #     redirect_to posts_path
    #   end
    # end
  end

  def show
    @user = User.find(params[:id])
    gon.post_count = @user.posts.count
    gon.good_like_count = @user.likes.where(good:true).count
    gon.evil_like_count = @user.likes.where(good:false).count
    gon.comment_count = @user.comments.count
    gon.good_like_total = Like.where(good:true).count
  end
  
end
 
