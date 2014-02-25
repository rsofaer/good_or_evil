class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.new
  end

  def create
    post_params = params.require(:post).permit(:text_overlay, :photo, :photo_link)
    @post = current_user.posts.create(post_params)

    AWS.config({
                 :access_key_id     => ENV['S3_KEY'],
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

    File.delete("#{Rails.root}/public#{@post.photo.url}")

    redirect_to @post
    flash[:notice] = "Succesfully created a post."

  end

  def show
    @post = Post.find(params[:id])

  end

  def edit
  end

  def update
    @post = Post.find(params[:id])
  end

  def destroy
  end

end
