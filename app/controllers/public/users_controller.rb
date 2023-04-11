class Public::UsersController < ApplicationController
  # 自分・他人

  def show
    @user=User.find(params[:id])
  end

  # 他人
  def index

    @users=User.all
  end

  # 自分
  def closet_index
    @spring_all=current_user.closets.where(season: 0)
    @summer_all=current_user.closets.where(season: 1)
    @autumn_all=current_user.closets.where(season: 2)
    @winter_all=current_user.closets.where(season: 3)
    @other_all=current_user.closets.where(season: 4)
  end

 # 自分のみ
  def edit
    @user=User.find(params[:id])
  end

  # 自分のみ
  def update
    @user=User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def favorite
    # favorite=current_user.favorites.all
    # @spring_all=[]
    # favorite.each do |fav|
    #   @spring_all << Closet.where(id: fav.id)
    # end
    # closet=Closet.find(params[favorite])
    # @spring_all=closet.where(season: 0)
    # @summer_all=closet.where(season: 1)
    # @autumn_all=closet.where(season: 2)
    # @winter_all=closet.where(season: 3)
    # @other_all=closet.where(season: 4)

    # favorite=current_user.favorites
    # @spring_all=favorite.closet.where(season: 0)
    # @summer_all=favorite.closet.where(season: 1)
    # @autumn_all=favorite.closet.where(season: 2)
    # @winter_all=favorite.closet.where(season: 3)
    # @other_all=favorite.closet.where(season: 4)
  end

  # フォロー中
  def following
    @user=User.find(params[:id])
    @following=@user.following
  end

  # フォロワー
  def follows
    @user=User.find(params[:id])
    @follows=@user.follows
  end

  # 自分のみ
  def quit_check
  end

  # 自分のみ
  def quit
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
