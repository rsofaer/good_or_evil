class SiteController < ApplicationController
      
  def index

    if current_user.nil?
      redirect_to root_path
    else
      redirect_to posts_path
    end
    
  end

  def show
    @user = current_user
    all_votes_all_posts_total = Like.where(likeable_type: Post).count
    gon.all_votes_all_posts_good = Like.where(likeable_type: Post, good: true).count
    gon.all_votes_all_posts_evil = Like.where(likeable_type: Post, good: false).count
   
    your_votes_all_posts_total = Like.where(likeable_type: Post, user_id: @user.id).count
    gon.your_votes_all_posts_good = Like.where(likeable_type: Post, user_id: @user.id, good: true).count
    gon.your_votes_all_posts_evil = Like.where(likeable_type: Post, user_id: @user.id, good: false).count
    
    all_votes_your_posts_total = @user.likes.where(likeable_type: Post).count
    gon.all_votes_your_posts_good = @user.likes.where(likeable_type: Post, good: true).count
    gon.all_votes_your_posts_evil = @user.likes.where(likeable_type: Post, good: false).count
    
  end
  
end
 
