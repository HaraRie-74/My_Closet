class Public::ClosetCommentsController < ApplicationController

  def create
    closet=Closet.find(params[:closet_id])
    comment=current_user.closet_comments.new(closet_comment_params)
    comment.closet_id=closet.id
    comment.save
    redirect_to closet_path(closet.id)
  end

  def destroy
    ClosetComment.find(params[:id]).destroy
    redirect_to closet_path(params[:closet_id])
  end


  private

  def closet_comment_params
    params.require(:closet_comment).permit(:comment)
  end

end
