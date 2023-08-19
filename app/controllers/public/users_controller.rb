class Public::UsersController < ApplicationController
  before_action :authenticate_user!#, only: [:index]

  def index
    @users = User.all
  end


  def show
    @user = current_user
    @users = User.all
  end

  def edit
    @user = current_user
  end

  def update
    @customer = current_user
    @user.update
  end

  def check
  end

  def withdrawal
    @user = current_user
    @user.withdrawal_status = true
    if @user.save
      reset_session
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
   end
end
