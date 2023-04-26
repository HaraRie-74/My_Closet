class Public::SearchsController < ApplicationController
  # ログイン済みでないとアクセスできない(deviseのメソッド)
  before_action :authenticate_user!

  def word_search
    @model = params[:model]
    @content = params[:content]
    if @content.blank?
      @records = []
    else
      @records = search_for(@model, @content)
      if @model == 'closet'
        @user_number = params[:user_num]
        @spring_all = @records.spring.publish
        @summer_all = @records.summer.publish
        @autumn_all = @records.autumn.publish
        @winter_all = @records.winter.publish
        @other_all = @records.other.publish
      end
    end
  end

  # def tag_search
  #   @tag = Tag.find(params[:tag_id])
  #   @closets = @tag.closets.all
  #   @spring_all = @closets.spring.publish
  #   @summer_all = @closets.summer.publish
  #   @autumn_all = @closets.autumn.publish
  #   @winter_all = @closets.winter.publish
  #   @other_all = @closets.other.publish
  # end

  def tag_search
    @tag = Tag.find(params[:tag_id])
    # リンクで受け取った値はstr型
    @user_number = params[:user_num].to_i
    # MyClosetだったら
    if @user_number == current_user.id
      @closets = @tag.closets.where(user_id: @user_number)
      @spring_all = @closets.spring
      @summer_all = @closets.summer
      @autumn_all = @closets.autumn
      @winter_all = @closets.winter
      @other_all = @closets.other
      # みんなの投稿だったら
    elsif @user_number == 0
      @closets = @tag.closets.all
      @spring_all = @closets.spring.publish
      @summer_all = @closets.summer.publish
      @autumn_all = @closets.autumn.publish
      @winter_all = @closets.winter.publish
      @other_all = @closets.other.publish
    else
      # 他人のClosetだったら
      @closets = @tag.closets.where(user_id: @user_number)
      @spring_all = @closets.spring.publish
      @summer_all = @closets.summer.publish
      @autumn_all = @closets.autumn.publish
      @winter_all = @closets.winter.publish
      @other_all = @closets.other.publish
    end
  end

  def tag_name_search
    @tag_word = params[:tag_word]
    @tag = Tag.find_by(tag_name: @tag_word)
    @user_number = params[:user_num].to_i
    if @tag_word.blank?
      @closets = []
    # MyClosetだったら
    elsif @user_number == current_user.id
      @closets = @tag.closets.where(user_id: @user_number)
      @spring_all = @closets.spring
      @summer_all = @closets.summer
      @autumn_all = @closets.autumn
      @winter_all = @closets.winter
      @other_all = @closets.other
      # みんなの投稿だったら
    elsif @user_number == 0
      @closets = @tag.closets.all
      @spring_all = @closets.spring.publish
      @summer_all = @closets.summer.publish
      @autumn_all = @closets.autumn.publish
      @winter_all = @closets.winter.publish
      @other_all = @closets.other.publish
    else
      # 他人のClosetだったら
      @closets = @tag.closets.where(user_id: @user_number)
      @spring_all = @closets.spring.publish
      @summer_all = @closets.summer.publish
      @autumn_all = @closets.autumn.publish
      @winter_all = @closets.winter.publish
      @other_all = @closets.other.publish
    end
  end


  private

  def search_for(model, content)
    if model == 'user'
      User.where('name LIKE ?', '%'+content+'%').where(is_deleted: false)
    elsif model == 'closet'
      Closet.where('purchase_store LIKE ?', '%'+content+'%')
    end
  end

end
