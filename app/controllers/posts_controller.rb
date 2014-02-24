class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    @posts = Post.all

    # respond_to do |f|
    #   # f.html
    #   f.json { render :json => @post }
    # end

  end

  def new
    @post = current_user.posts.new
  end

  def create
    post_params = params.require(:post).permit(:text_overlay, :photo, :photo_link)
    @post = current_user.posts.create(post_params)
    #The AWS code establishes credentials to access the S3 storage.
    AWS.config({
                 :access_key_id     =>  ENV['S3_KEY'],
                 :secret_access_key => ENV['S3_SECRET']
    })
    #The s3 variable is creating a new connection to the S3 cloud storage.
    s3 = AWS::S3.new
    bucket_name = "goodevil" #This is the repository for images on the amazon account.
    "public#{@post.photo.url}"
    File.basename("public#{@post.photo.url}")
    bucket = s3.buckets[bucket_name]
    s3.buckets["goodevil"].objects[File.basename("public#{@post.photo.url}")].write(:file => "public#{@post.photo.url}")
    @post.update_attributes(aws_url: "https://s3.amazonaws.com/goodevil/"+"#{@post.photo.filename}")
    #need to manually set the amazon url, because carrierwave default is the public folder url.
    #Then the file gets deleted from the public folder.
    redirect_to @post
    File.delete("#{Rails.root}/public#{@post.photo.url}")

    respond_to do |f|
      # f.html
      f.json { render :json => @post }
    end

  end

  def show
    @post = Post.find(params[:id])

  end

  def like_post
    like_params = params.require(:like).permit(:good, :likeable_id, :likeable_type)
    like = Like.create(like_params)
    post = Post.find(like_params["likeable_id"])
    good_count = post.likes.where(good: true).count
    evil_count = post.likes.where(good: false).count
    @like_count = {good_count: good_count, evil_count: evil_count}
    respond_to do |f|
      f.json { render :json => @like_count }
    end
  end

  def like_comment
  end


  def edit
  end

  def update
  end

  def destroy
  end

end
