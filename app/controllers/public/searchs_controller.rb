class Public::SearchsController < ApplicationController

  def word_search
    @model=params[:model]
    @content=params[:content]
    if @content.blank?
      @records=[]
    else
      @records=search_for(@model, @content)
      if @model=='closet'
        @spring_all=@records.where(season: 0).publish
        @summer_all=@records.where(season: 1).publish
        @autumn_all=@records.where(season: 2).publish
        @winter_all=@records.where(season: 3).publish
        @other_all=@records.where(season: 4).publish
      end
    end
  end

  def tag_search
    @tag=Tag.find(params[:tag_id])
    @closets=@tag.closets.all
    @spring_all=@closets.where(season: 0).publish
    @summer_all=@closets.where(season: 1).publish
    @autumn_all=@closets.where(season: 2).publish
    @winter_all=@closets.where(season: 3).publish
    @other_all=@closets.where(season: 4).publish
  end


  private

  def search_for(model, content)
    if model=='user'
      User.where('name LIKE ?', '%'+content+'%')
    elsif model=='closet'
      Closet.where('purchase_store LIKE ?', '%'+content+'%')
    end
  end

end
