class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :new_post 

  def stored_location_for(resource)
    nil
  end

  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_up_path_for(resource)
    posts_path
  end


  def new_post
    @post = Post.new
  end 

end
