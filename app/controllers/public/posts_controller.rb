class Public::PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def new
    @post = Post.new
  end

  def index
    to = Time.current.at_end_of_day
    from = (to -6.day).at_beginning_of_day
    posts = Post.includes(:favorites).order(created_at: :desc)
    if params[:mypage]
      posts = posts.where(user_id: current_user.id)
    end
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(4)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if  @post.save
      flash[:notice] = "投稿が成功しました。"
      redirect_to posts_path
    else
      flash[:alert] = "投稿に失敗しました。"
      redirect_to posts_path
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
      flash[:alert] = "投稿を削除しました。"
      redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :text, :image, :user_id)
  end
end
