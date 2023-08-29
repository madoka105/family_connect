class Public::UsersController < ApplicationController
  before_action :authenticate_user!#, only: [:index]
  # before_action :set_user, only: [:favorites]

  # def favorites
  #   favorites = Favorite.where(user_id: :@user.id).pluck(:post_id)
  #   @favorite_posts = Post.find(favorites)
  # end

  # フォロー一覧
  def follows
    user = User.find(params[:id])
    @users = user.following_users.page(params[:page]).per(4)
  end

  # フォロワー一覧
  def followers
    user = User.find(params[:id])
    @users = user.follower_users.page(params[:page]).per(4)
  end

  def index
    @users = User.all.page(params[:page]).per(4)
  end

  def show
    # where構文は、SQLと呼ばれるもので、
    # その条件に一致したものを取得します。
    @user = User.find(params[:id])
    @users = @user.following_users
    @posts = @user.posts.page(params[:page]).per(4)
  end

  def mypage
    # where構文は、SQLと呼ばれるもので、
    # その条件に一致したものを取得します。
    @user = current_user
    @users = @user.following_users
  end

  def edit
    # 編集用のフォームを表示するために、現在の顧客情報を取得します
    @user = current_user
  end

  def update
    # 編集フォームから送信されたパラメータで顧客情報を更新します
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "登録情報を更新しました。"
      redirect_to users_mypage_path
    else
      render :edit
    end
  end

  def check
    # 退会確認画面を表示するだけなので、特に処理は必要ありません
  end

  public

  def withdrawal
      # current_user. = 現在のログインしているユーザーの情報
      # @customer の中に現在ログインしているユーザーの情報を入れます。
      @user = current_user
      # 現在ログインしている、ユーザーのis_withdrawlをtrueに変更する
      @user.update(is_withdrawal: true)
      reset_session
      # deviceの機能でサインアウトを実行します。
      sign_out @user # 退会処理後に自動でログアウトさせる
      flash[:notice] = "退会処理が完了しました。ご利用いただきありがとうございました。"
      redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :birthday, :phone_number)
  end


  # def set_user
  #   @user = User.find(params[:id])
  # end
end
