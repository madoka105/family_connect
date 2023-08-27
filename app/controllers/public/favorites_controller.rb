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
    # to = Time.current.at_end_of_day
    # from = (to -6.day).at_beginning_of_day
    # posts = @user.posts.includes(:favorites).sort_by { |post| -post.favorites.where(created_at: from...to).count }
    # post_ids = Favorite.where(user_id: @user.id).pluck(:post_id)
    # posts = Post.where(id: post_ids)
    # favorite = Favorite.where(user_id: @user.id).group(:post_id).order('count(post_id) desc').pluck(:post_id)
    # posts = Post.find(favorite)
    # posts = Post.joins(:favorites).where(favorites: {user_id: @user.id}).group(:id).order('count(post_id) desc')
    # .select('posts.*, COUNT(favorites.id) AS favorites_count').group('posts.id').order('favorites_count DESC')
    posts = Post.joins(:favorites).where(favorites: {user_id: @user.id}).includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(4)
  end
end
