class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    @posts = Post.order(:created_at).page params[:page]

    gon.posts = @posts.map do |post|
      {id: post.id, 
      good_count: post.likes.where(good:true).count,
      evil_count: post.likes.where(good:false).count}
    end
   
    @post = Post.new
  end

  def new
    @post = current_user.posts.new
  end

  def create
    post_params = params.require(:post).permit(:text_overlay, :photo, :photo_link)
    post = Post.create(post_params)
    img = Magick::ImageList.new("#{Rails.root}/public#{post.photo.url}")
    txt = Magick::Draw.new

    txt.annotate(img, 0, 0, 0, 60, "#{post.text_overlay}") {
      self.gravity = Magick::SouthGravity
      self.pointsize = 48
      self.stroke = 'black'
      self.fill = '#ffffff'
      self.font_weight = Magick::BoldWeight
    }
    img.write("#{Rails.root}/public#{post.photo.url}")


    img.format = 'jpeg'
    ImageWorker.perform_async(post.id)
    current_user.posts << post # adding posts to current_user
    redirect_to posts_path
    
  end
  
  def show
    @user = current_user

  end

  def create_comment
    comment_params = params.require(:comment).permit(:body, :post_id)
    @comment = Comment.create(comment_params)
    current_user.comments << @comment  # adding comments to current_user
    post = Post.find(comment_params["post_id"])
    respond_to do |f|
      # f.html
      f.json { render :json => @comment, only: [:id, :body, :post_id]}
    end

  end

  def like
    like_params = params.require(:like).permit(:good, :likeable_id, :likeable_type)
    like_params["user_id"]=current_user.id # adding likes to current_user
    like = Like.create(like_params)
      if like_params["likeable_type"] == "Post"
        post = Post.find(like_params["likeable_id"])
        post_good_count = post.likes.where(good:true).count
        post_evil_count = post.likes.where(good:false).count
        @like_count = {good_count: post_good_count, evil_count: post_evil_count, id: post.id}
      elsif like_params["likeable_type"] == "Comment"
        comment = Comment.find(like_params["likeable_id"])
        comment_good_count = comment.likes.where(good:true).count
        comment_evil_count = comment.likes.where(good:false).count
        @like_count = {good_count: comment_good_count, evil_count: comment_evil_count}
      end
  
    respond_to do |f|
      f.json { render :json => @like_count }
    end
  end


  def edit
  end

  def update
    @post = Post.find(params[:id])
  end

  def destroy
  end

end
