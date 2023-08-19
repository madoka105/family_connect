class Public::UsersController < ApplicationController
  before_action :authenticate_user!#, only: [:index]

  # フォロー一覧
  def follows
    user = User.find(params[:id])
    @users = user.following_users
  end

  # フォロワー一覧
  def followers
    user = User.find(params[:id])
    @user = user.follower_users
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_users
  end

  def followers
    user = User.find(params[:id])
    @user = user.follower_users
  end

  def index
    @users = User.all
  end


  def show
    @users = User.all
    @id = params[:id] || current_user.id
    @user = User.find(@id)
    @following_users = @user.following_users
    @follower_users = @user.follower_users
  end

  def edit
    # 編集用のフォームを表示するために、現在の顧客情報を取得します
    @user = current_user
  end

  def update
    # 編集フォームから送信されたパラメータで顧客情報を更新します
    @user = current_user
    if @user.update(user_params)
      redirect_to users_mypage_path notice: "登録情報を更新しました。"
    else
      render :edit
    end
  end

  def check
    # 退会確認画面を表示するだけなので、特に処理は必要ありません
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
