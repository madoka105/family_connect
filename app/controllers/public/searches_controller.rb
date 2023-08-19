class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
      @posts = Post.looks(params[:word])
      render :search_result
  end
end

