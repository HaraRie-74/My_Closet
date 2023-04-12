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
    # favorite=current_user.favorites
    # @spring_all=[]
    # favorite.each do |fav|
    #   @spring_all << Closet.where(id: fav.closet_id)
    # end

    # closet=Closet.find(params[favorite])
    # @spring_all=closet.where(season: 0)
    # @summer_all=closet.where(season: 1)
    # @autumn_all=closet.where(season: 2)
    # @winter_all=closet.where(season: 3)
    # @other_all=closet.where(season: 4)

    closets = current_user.favorited_closets
    @spring_all = closets.spring
    @summer_all = closets.summer
    @autumn_all = closets.autumn
    @winter_all = closets.winter
    @other_all = closets.other

    # closet=Closet.all
    # favorite=closet.favorites.where(user_id: current_user.id)
    # @spring_all=favorite.closets.where(season: 0)

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
