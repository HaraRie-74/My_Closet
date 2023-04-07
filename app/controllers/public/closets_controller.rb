class Public::ClosetsController < ApplicationController

  # 自分のみ
  def new
    @closet=Closet.new
    @tag=Tag.new
  end

  # 自分のみ
  def create
    closet=current_user.closets.new(closet_params)
    if closet.save
      redirect_to  new_closet_tag_path(closet.id)
    else
      render "new"
    end
  end

  # 他人のみ
  def index
  end


# 自分・他人
  def show
    @closet=Closet.find(params[:id])
    @closet_tags=ClosetTag.where(closet_id: @closet.id)
  end

# 自分のみ
  def edit
  end

  def update
  end

  def destroy
  end

  private

  def closet_params
    params.require(:closet).permit(:purchase_date, :purchase_store, :purchase_price, :season, :memo, images:[])
  end

end
