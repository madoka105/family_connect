class Admin::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end

  def index
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = "投稿を削除しました。"
    redirect_to admin_root_path
  end
end