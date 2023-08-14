class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end


  def index
    @posts = Post.all.page(params[:page]).per(4)
    to = Time.current.at_end_of_day
    from = (to -6.day).at_beginning_of_day
    @posts = Post.includes(:favorites).sort_by { |post| -post.favorites.where(created_at: from...to).count }
    
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:title, :text, :image, :user_id)
  end
end
