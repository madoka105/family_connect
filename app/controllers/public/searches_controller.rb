class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @post = Post.all.page(params[:page]).per(4)
    @posts = Post.looks(params[:word])
    render :search_result
  end
end

