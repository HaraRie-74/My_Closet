class Public::TagsController < ApplicationController
  def new
    @closet=Closet.find(params[:closet_id])
    @tag=Tag.new
    @closet_tags=ClosetTag.where(closet_id: @closet.id)
  end

  def create
    tag=Tag.new(tag_params)
    if tag.save
      closet_tag=ClosetTag.new
      closet=Closet.find(params[:closet_id])
      closet_tag.tag_id=tag.id
      closet_tag.closet_id=closet.id
      if closet_tag.save
        redirect_to new_closet_tag_path(closet.id)
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def destroy
  end

  private

  def tag_params
    params.require(:tag).permit(:tag_name)
  end
end
