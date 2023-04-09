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
