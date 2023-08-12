class Public::PostsController < ApplicationController
  def index
    @posts = Post.all.page(params[:page]).per(4)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to '/posts'
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:title, :text, :image)
  end
end
