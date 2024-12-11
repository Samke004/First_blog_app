class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @post }
        format.js
      end
    else
      flash[:alert] = "Neuspješno dodavanje komentara."
      redirect_to @post
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.turbo_stream # Za Turbo Stream odgovore
      format.html { redirect_to post_path(@comment.post), notice: "Komentar je uspešno obrisan." }
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