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
  end
  
end
 