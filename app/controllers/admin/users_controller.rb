class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.page(params[:page]).per(4)
  end

  def show
    @users = User.find(params[:id])
    
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "変更内容を保存しました。"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :is_withdrawal)
  end
end
