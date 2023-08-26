class Admin::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end

  def index
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
      flash[:aleret] = "投稿を削除しました。"
      redirect_to admin_root_path(@post.id)
  end
end
