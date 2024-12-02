class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:following, :followers]
  def show
    @user = User.find(params[:id])
  end
  def following
    @title = "Praćenje"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  def followers
    @title = "Pratitelji"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, contact_emails_attributes: [:id, :email, :_destroy])
  end
  

end
