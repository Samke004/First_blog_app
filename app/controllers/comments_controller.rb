class CommentsController < ApplicationController
    before_action :authenticate_user!
  
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
      @comment = current_user.comments.find(params[:id])
      @post = @comment.post
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to @post }
        format.js
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  