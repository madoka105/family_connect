class Public::UsersController < ApplicationController
  def show
    @user = current_user
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
end
