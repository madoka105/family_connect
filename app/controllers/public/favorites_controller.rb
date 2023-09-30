class Public::FavoritesController < ApplicationController
before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to request.referer
  end

  def index
    @user = User.find(params[:user_id])
    posts = Post.joins(:favorites).where(favorites: {user_id: @user.id}).includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(4)
  end
end
