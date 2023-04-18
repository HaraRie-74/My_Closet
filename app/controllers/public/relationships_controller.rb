class Public::RelationshipsController < ApplicationController
  def create
    @other_user = User.find(params[:user_id])
    current_user.follow(@other_user)
  end

  def destroy
    @other_user = User.find(params[:user_id])
    current_user.unfollow(@other_user)
  end
end
