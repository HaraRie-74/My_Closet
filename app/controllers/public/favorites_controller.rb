class Public::FavoritesController < ApplicationController

  def create
    @closet = Closet.find(params[:closet_id])
    favorite = current_user.favorites.new(closet_id: @closet.id)
    favorite.save
  end

  def destroy
    @closet = Closet.find(params[:closet_id])
    favorite = current_user.favorites.find_by(closet_id: @closet.id)
    favorite.destroy
  end

end
