class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(user: current_user))

    respond_to do |format|
      if @comment.save
        NotificationMailer.new_comment(@comment).deliver_later
        format.turbo_stream
        format.html { redirect_to @post, notice: "Komentar je dodan." }
      else
        format.html { redirect_to @post, alert: "Neuspješno dodavanje komentara." }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to post_path(@comment.post), notice: "Komentar je uspješno obrisan." }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
