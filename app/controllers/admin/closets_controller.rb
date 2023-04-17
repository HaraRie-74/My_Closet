class Admin::ClosetsController < ApplicationController
  # ログイン済みでないとアクセスできない(deviseのメソッド)
  before_action :authenticate_admin!

  # 管理者は非公開投稿を見ることができる
  def index
    @spring_all = Closet.spring
    @summer_all = Closet.summer
    @autumn_all = Closet.autumn
    @winter_all = Closet.winter
    @other_all = Closet.other
  end

# 自分・他人
  def show
    @closet = Closet.find(params[:id])
    @closet_tags = @closet.tags
  end

end
