class Admin::ClosetsController < ApplicationController

  # 管理者は非公開投稿を見ることができる
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

end
