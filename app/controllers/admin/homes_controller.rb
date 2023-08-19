class Admin::HomesController < ApplicationController
  def top
    @params = params[:id]
    @post = Post.where(user_id: @params).page(params[:page]).per(10).order(created_at: :desc)
    @posts = Post.page(params[:page]).per(7).order(created_at: :desc)
  end
end
