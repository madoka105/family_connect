class Admin::SearchesController < ApplicationController
   before_action :authenticate_admin!

  def search
      @users = User.looks(params[:word])
      render :search_result
  end
end
