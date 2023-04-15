class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def closet_index
    @spring_all = User.find(params[:id]).closets.spring
    @summer_all = User.find(params[:id]).closets.summer
    @autumn_all = User.find(params[:id]).closets.autumn
    @winter_all = User.find(params[:id]).closets.winter
    @other_all = User.find(params[:id]).closets.other
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
    closets = User.find(params[:id]).favorited_closets
    @spring_all = closets.spring
    @summer_all = closets.summer
    @autumn_all = closets.autumn
    @winter_all = closets.winter
    @other_all = closets.other
  end
end
