class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def new
    @post = current_user.posts.new
  end

  def create
    post_params = params.require(:post).permit(:url, :photo, :text_overlay, :photolink)
    @post = Post.create(post_params)
    #The AWS code establishes credentials to access the S3 storage.
    AWS.config({
                 :access_key_id     =>  ENV['S3_KEY'],
                 :secret_access_key => ENV['S3_SECRET']
    })
    #The s3 variable is creating a new connection to the S3 cloud storage.
    s3 = AWS::S3.new
    bucket_name = "goodevil" #This is the repository for images on the amazon account.
    file_name = "public/#{@post.photo.url}"
    key = File.basename("public/#{@post.photo.url}")
    bucket = s3.buckets[bucket_name]
    s3.buckets["goodevil"].objects[key].write(:file => file_name)
    @post.update_attributes(aws_url: "https://s3.amazonaws.com/goodevil/"+"#{@post.photo.filename}")
    #need to manually set the amazon url, because carrierwave default is the public folder url.
    #Then the file gets deleted from the public folder.
    File.delete("#{Rails.root}/public/#{@post.photo.url}")

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end
end
