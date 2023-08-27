class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  # 検索処理を行い、@posts に代入する
  def search
    @posts = Post.looks(params[:word]).page(params[:page]).per(4)

    @search_word = params[:word] # フォームから送信された検索キーワード.

    # @search_counts に検索結果のヒット数を代入する
    @search_counts = @posts.count
    render :search_result

  end
end

