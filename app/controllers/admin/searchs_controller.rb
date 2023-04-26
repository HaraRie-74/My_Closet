class Admin::SearchsController < ApplicationController
   # ログイン済みでないとアクセスできない(deviseのメソッド)
  before_action :authenticate_admin!

  def word_search
    @model = params[:model]
    @content = params[:content]
    if @content.blank?
      @records = []
    else
      @records = search_for(@model, @content)
      if @model == 'closet'
        @user_number = params[:user_num]
        @spring_all = @records.spring
        @summer_all = @records.summer
        @autumn_all = @records.autumn
        @winter_all = @records.winter
        @other_all = @records.other
      end
    end
  end

  def tag_search
    @tag = Tag.find(params[:tag_id])
    @user_number = params[:user_num].to_i
    if @user_number == 0
      @closets = @tag.closets.all
      @spring_all = @closets.spring
      @summer_all = @closets.summer
      @autumn_all = @closets.autumn
      @winter_all = @closets.winter
      @other_all = @closets.other
    else
      @closets = @tag.closets.where(user_id: @user_number)
      @spring_all = @closets.spring
      @summer_all = @closets.summer
      @autumn_all = @closets.autumn
      @winter_all = @closets.winter
      @other_all = @closets.other
    end
  end

  def tag_name_search
    @tag_word = params[:tag_word]
    @tag = Tag.find_by(tag_name: @tag_word)
    @user_number = params[:user_num].to_i
    if @tag_word.blank?
      @closets = []
      # みんなの投稿だったら
    elsif @user_number == 0
      @closets = @tag.closets.all
      @spring_all = @closets.spring
      @summer_all = @closets.summer
      @autumn_all = @closets.autumn
      @winter_all = @closets.winter
      @other_all = @closets.other
    else
      # 他人のClosetだったら
      @closets = @tag.closets.where(user_id: @user_number)
      @spring_all = @closets.spring
      @summer_all = @closets.summer
      @autumn_all = @closets.autumn
      @winter_all = @closets.winter
      @other_all = @closets.other
    end
  end


  private

  def search_for(model, content)
    if model == 'user'
      User.where('name LIKE ?', '%'+content+'%')
    elsif model == 'closet'
      Closet.where('purchase_store LIKE ?', '%'+content+'%')
    end
  end

end
