class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def closet_index
    @user = User.find(params[:id])
    @spring_all = @user.closets.spring
    @summer_all = @user.closets.summer
    @autumn_all = @user.closets.autumn
    @winter_all = @user.closets.winter
    @other_all = @user.closets.other
  end

  def following
    @user = User.find(params[:id])
    @following = @user.following
  end

  def follows
    @user = User.find(params[:id])
    @follows = @user.follows
  end

  def favorite
    @user = User.find(params[:id])
    closets = @user.favorited_closets
    @spring_all = closets.spring
    @summer_all = closets.summer
    @autumn_all = closets.autumn
    @winter_all = closets.winter
    @other_all = closets.other
  end

  def quit_check
    @user = User.find(params[:id])
  end

  # def quit
  #   user = User.find(params[:id])
  #   user.update(is_deleted: true)
  #   user.closets.destroy_all
  #   flash[:notice] = "退会させました"
  #   redirect_to admin_users_path
  # end

  def quit
    user = User.find(params[:id])
    user.update(is_deleted: true)
    user.closets.destroy_all
    user.closet_comments.destroy_all
    user.favorites.destroy_all
    user.active_relationships.destroy_all
    user.passive_relationships.destroy_all
    flash[:notice] = "退会させました"
    redirect_to admin_users_path
  end

end
