class Admin::ClosetCommentsController < ApplicationController

  def update
    @closet = Closet.find(params[:closet_id])
    closet_comment = ClosetComment.find(params[:id])
    closet_comment.update(comment: "管理者によって削除されました")
    # ClosetComment.find(params[:id]).destroy
  end

end
