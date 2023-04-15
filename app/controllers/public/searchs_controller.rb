class Public::SearchsController < ApplicationController

  def word_search
    @model = params[:model]
    @content = params[:content]
    if @content.blank?
      @records = []
    else
      @records = search_for(@model, @content)
      if @model == 'closet'
        @spring_all = @records.spring.publish
        @summer_all = @records.summer.publish
        @autumn_all = @records.autumn.publish
        @winter_all = @records.winter.publish
        @other_all = @records.other.publish
      end
    end
  end

  def tag_search
    @tag = Tag.find(params[:tag_id])
    @closets = @tag.closets.all
    @spring_all = @closets.spring.publish
    @summer_all = @closets.summer.publish
    @autumn_all = @closets.autumn.publish
    @winter_all = @closets.winter.publish
    @other_all = @closets.other.publish
  end

  def tag_name_search
    @tag_word = params[:tag_word]
    @tag = Tag.find_by(tag_name: @tag_word)
    if @tag.blank?
      @records = []
    else
      closets = @tag.closets.all
      @spring_all = closets.spring.publish
      @summer_all = closets.summer.publish
      @autumn_all = closets.autumn.publish
      @winter_all = closets.winter.publish
      @other_all = closets.other.publish
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
