class Admin::SearchesController < ApplicationController
   before_action :authenticate_admin!

  def search
     @searches = User.all.page(params[:page]).per(4)
     @users = User.looks(params[:word])
      render :search_result
  end

  def index
  end
end
