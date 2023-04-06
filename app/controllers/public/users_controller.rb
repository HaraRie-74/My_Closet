class Public::UsersController < ApplicationController
  # 自分・他人
  def show
    @user=User.find(params[:id])
  end

  # 他人
  def index
  end

  # 自分・他人
  def closet_index
    user=User.find(params[:id])
    @closets=Closet.all
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
