class Public::ClosetsController < ApplicationController

  # 自分のみ
  def new
    @closet=Closet.new
  end

  # 自分のみ
  def create
    closet=current_user.closets.new(closet_params)
    # split(',')=>入力された文字列を,で区切り、配列にする
    tag_list=params[:closet][:tag_name].split(',')
    if closet.save
      closet.save_tag(tag_list)
      redirect_to closet_path(closet.id)
    else
      render "new"
    end
  end

  # 他人のみ
  def index
    @spring_all=Closet.where(season: 0)
    @summer_all=Closet.where(season: 1)
    @autumn_all=Closet.where(season: 2)
    @winter_all=Closet.where(season: 3)
    @other_all=Closet.where(season: 4)

  end


# 自分・他人
  def show
    @closet=Closet.find(params[:id])
    @closet_tags=@closet.tags
    @comment=ClosetComment.new
  end

# 自分のみ
  def edit
    @closet=Closet.find(params[:id])
    # join(',')=>配列を,で区切った文字列にする
    @closet_tag=@closet.tags.pluck(:tag_name).join(',')
  end

  def update
    closet=Closet.find(params[:id])
    # split(',')=>入力された文字列を,で区切り、配列にする
    tag_list=params[:closet][:tag_name].split(',')
    if closet.update(closet_params)
      closet.save_tag(tag_list)
      redirect_to closet_path(closet.id)
    else
      render 'edit'
    end
  end

  def destroy
    closet=Closet.find(params[:id])
    if closet.destroy
      @spring_all=Closet.where(season: 0)
      @summer_all=Closet.where(season: 1)
      @autumn_all=Closet.where(season: 2)
      @winter_all=Closet.where(season: 3)
      @other_all=Closet.where(season: 4)
      redirect_to closet_index_path(current_user.id)
    else
      render 'show'
    end
  end

  private

  def closet_params
    params.require(:closet).permit(:purchase_date, :purchase_store, :purchase_price, :season, :memo, images:[])
  end

end
