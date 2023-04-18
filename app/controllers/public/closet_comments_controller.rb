class Public::ClosetCommentsController < ApplicationController
  # ログイン済みでないとアクセスできない(deviseのメソッド)
  before_action :authenticate_user!

  def create
    @closet = Closet.find(params[:closet_id])
    comment = current_user.closet_comments.new(closet_comment_params)
    comment.closet_id = @closet.id
    @comment = ClosetComment.new
    unless comment.save
      @closet_tags = @closet.tags
      # render "public/closets/show"
      render template:"public/homes/top"
    end
  end

  def destroy
    @closet = Closet.find(params[:closet_id])
    ClosetComment.find(params[:id]).destroy
    @comment = ClosetComment.new
  end


  private

  def closet_comment_params
    params.require(:closet_comment).permit(:comment)
  end

end
