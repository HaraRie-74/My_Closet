class Public::SearchsController < ApplicationController

  def word_search
    @model=params[:model]
    @content=params[:content]
    if @content.blank?
      @records=[]
    else
      @records=search_for(@model, @content)
      if @model=='closet'
        @spring_all=@records.where(season: 0)
        @summer_all=@records.where(season: 1)
        @autumn_all=@records.where(season: 2)
        @winter_all=@records.where(season: 3)
        @other_all=@records.where(season: 4)
      end
    end
  end

  def tag_search
    @tag=Tag.find(params[:tag_id])
    @closets=@tag.closets.all
    @spring_all=@closets.where(season: 0)
    @summer_all=@closets.where(season: 1)
    @autumn_all=@closets.where(season: 2)
    @winter_all=@closets.where(season: 3)
    @other_all=@closets.where(season: 4)
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
