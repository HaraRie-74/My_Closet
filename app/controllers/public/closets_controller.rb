class Public::ClosetsController < ApplicationController

  # 自分のみ
  def new
    @closet=Closet.new
  end

  # 自分のみ
  def create
    closet=current_user.closets.new(closet_params)
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
    @tag_list=Tag.all

  end


# 自分・他人
  def show
    @closet=Closet.find(params[:id])
    @closet_tags=@closet.tags
  end

# 自分のみ
  def edit
    @closet=Closet.find(params[:id])
  end

  def update
    closet=Closet.find(params[:id])
    closet.update(closet_params)
    redirect_to new_closet_tag_path(closet.id)
  end

  def destroy
    closet=Closet.find(params[:id])
    closet.destroy
    redirect_to closet_index_path(closet.user.id)
  end

  private

  def closet_params
    params.require(:closet).permit(:purchase_date, :purchase_store, :purchase_price, :season, :memo, images:[])
  end

end
