class Public::ClosetsController < ApplicationController
  # ログイン済みでないとアクセスできない(deviseのメソッド)
  before_action :authenticate_user!
  # 他ユーザーに対するアクセス制限
  before_action :is_matching_login_user, only:[:edit, :update, :destroy]

  # 自分のみ
  def new
    @closet = Closet.new
  end

  # 自分のみ
  def create
    @closet = current_user.closets.new(closet_params)
    # split(',')=>入力された文字列を,で区切り、配列にする
    tag_list = params[:closet][:tag_name].split(',')
    if @closet.save
      @closet.save_tag(tag_list)
      flash[:notice]="投稿に成功しました"
      redirect_to closet_path(@closet.id)
    else
      render "new"
    end
  end

  # 他人のみ
  def index
    # タグ検索機能で使用
    @user_number = 0
    @spring_all = Closet.spring.publish
    @summer_all = Closet.summer.publish
    @autumn_all = Closet.autumn.publish
    @winter_all = Closet.winter.publish
    @other_all = Closet.other.publish
  end


# 自分・他人
  def show
    @closet = Closet.find(params[:id])
    @closet_tags = @closet.tags
    @comment = ClosetComment.new
  end

# 自分のみ
  def edit
    @closet = Closet.find(params[:id])
    # join(',')=>配列を,で区切った文字列にする
    @closet_tag = @closet.tags.pluck(:tag_name).join(',')
  end

  def update
    closet = Closet.find(params[:id])
    # formから、@closetオブジェクトを参照してtag_nameの値が一緒に送信されてくる
    # split(',')=>入力された文字列を,で区切り、配列にする
    tag_list = params[:closet][:tag_name].split(',')
    if closet.update(closet_params)
      closet.save_tag(tag_list)
      flash[:notice]="投稿内容を変更しました"
      redirect_to closet_path(closet.id)
    else
      render 'edit'
    end
  end

  def destroy
    closet = Closet.find(params[:id])
    if closet.destroy
      @spring_all = Closet.spring
      @summer_all = Closet.summer
      @autumn_all = Closet.autumn
      @winter_all = Closet.winter
      @other_all = Closet.other
      flash[:notice]="投稿を削除しました"
      redirect_to closet_index_path(current_user.id)
    else
      render 'show'
    end
  end


  private

  def closet_params
    params.require(:closet).permit(:purchase_date, :purchase_store, :purchase_price, :season, :memo, :is_published_flag, images:[])
  end

  def is_matching_login_user
    closet = Closet.find(params[:id])
    unless closet.user_id == current_user.id
      flash[:notice] = "アクセスできません"
      redirect_to user_path(current_user.id)
    end
  end

end
