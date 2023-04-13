class Admin::ClosetCommentsController < ApplicationController

  def destroy
    closet_comment = ClosetComment.find(params[:id])
    closet_comment.destroy
    # ClosetComment.find(params[:id]).destroy
    redirect_to request.referer
  end

end
