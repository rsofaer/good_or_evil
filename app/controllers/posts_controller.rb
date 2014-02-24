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

  end

  def show
    @post = Post.find(params[:id])

  end

  def edit
  end

  def update
  end

  def destroy
  end

end
