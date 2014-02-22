class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def new
    @post = current_user.posts.new
  end

  def create
    post_params = params.require(:post).permit(:text_overlay, :photo, :photo_link, :good, :evil)
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Created post successfully.'
    else
      render action: 'new'
    end
  end

  def create
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
