class Public::UsersController < ApplicationController
  # ログイン済みでないとアクセスできない(deviseのメソッド)
  before_action :authenticate_user!
  # 他ユーザーに対するアクセス制限
  before_action :is_matching_login_user, only:[:edit, :update, :quit_check, :quit]
  # ゲストユーザーは会員編集させない
  before_action :ensure_guest_user, only:[:edit, :update, :quit_check, :quit]
  # 自分・他人

  def show
    @user = User.find(params[:id])
  end

  # 他人
  def index
    @users = User.all
  end

  # 自分
  def closet_index
    @user = User.find(params[:id])
    if current_user == @user
      @spring_all = current_user.closets.spring
      @summer_all = current_user.closets.summer
      @autumn_all = current_user.closets.autumn
      @winter_all = current_user.closets.winter
      @other_all = current_user.closets.other
    else
      # 公開ステータスのみ表示
      @spring_all = @user.closets.spring.publish
      @summer_all = @user.closets.summer.publish
      @autumn_all = @user.closets.autumn.publish
      @winter_all = @user.closets.winter.publish
      @other_all = @user.closets.other.publish
    end
  end

 # 自分のみ
  def edit
    @user = User.find(params[:id])
  end

  # 自分のみ
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "会員情報を変更しました"
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def favorite
    closets = current_user.favorited_closets
    @spring_all = closets.spring
    @summer_all = closets.summer
    @autumn_all = closets.autumn
    @winter_all = closets.winter
    @other_all = closets.other
  end

  # フォロー中
  def following
    @user = User.find(params[:id])
    @following = @user.following
  end

  # フォロワー
  def follows
    @user = User.find(params[:id])
    @follows = @user.follows
  end

  # 自分のみ
  def quit_check
    @user = current_user
  end

  # 自分のみ
  def quit
    user = User.find(params[:id])
    user.update(is_deleted: true)
    # 全てのsessionを破棄
    reset_session
    flash[:notice] = "退会処理が完了しました。ご利用ありがとうございました。"
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      flash[:notice] = "アクセスできません"
      redirect_to user_path(current_user.id)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      flash[:notice] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      redirect_to user_path(current_user)
    end
  end

end
