class Public::FavoritesController < ApplicationController
  def create
    closet=Closet.find(params[:closet_id])
    favorite=current_user.favorites.new(closet_id: closet.id)
    favorite.save
    redirect_to closet_path(closet.id)
  end

  def destroy
    closet=Closet.find(params[:closet_id])
    favorite=current_user.favorites.find_by(closet_id: closet.id)
    favorite.destroy
    redirect_to closet_path(closet.id)
  end
end
