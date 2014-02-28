class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    @posts = Post.order(:created_at).reverse_order.page params[:page]

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
    if post.text_overlay.nil?
      post.update_attributes(text_overlay: "")
    end

    #don't know why blankimage worker can't get the updated url, but works here....

    if post.photo.file.nil?
      img = Magick::Image.new(360,480) {
        self.background_color = "gray"
      }
      rmagick_bg_name = SecureRandom.hex

      dir = File.dirname("#{Rails.root}/public/uploads/post/photo/#{post.id}/#{rmagick_bg_name}.jpg")
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      img.write("#{Rails.root}/public/uploads/post/photo/#{post.id}/#{rmagick_bg_name}.jpg")

      txt = Magick::Draw.new

      txt.annotate(img, 0, 0, 0, 60, "#{post.text_overlay}") {
        self.gravity = Magick::CenterGravity
        self.pointsize = 20
        self.stroke = '#000000'
        self.fill = '#ffffff'
        self.font_weight = Magick::BoldWeight
      }
      img.write("#{Rails.root}/public/uploads/post/photo/#{post.id}/#{rmagick_bg_name}.jpg")
      img.format = 'jpeg'

      s3 = AWS::S3.new
      bucket_name = "goodevil"
      file_name = "#{Rails.root}/public/uploads/post/photo/#{post.id}/#{rmagick_bg_name}.jpg"
      key = File.basename("#{Rails.root}/public/uploads/post/photo/#{post.id}/#{rmagick_bg_name}.jpg")
      bucket = s3.buckets[bucket_name]
      s3.buckets["goodevil"].objects[key].write(:file => file_name)
      post.update_attributes(photo_link: "https://s3.amazonaws.com/goodevil/"+"#{rmagick_bg_name}.jpg")
      File.delay_for(2.minutes).delete("#{Rails.root}/public/uploads/post/photo/#{post.id}/#{rmagick_bg_name}.jpg")
      redirect_to root_path
    else

      ImageWorker.perform_async(post.id)
      current_user.posts << post # adding posts to current_user
      redirect_to root_path
      binding.pry
    end
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
