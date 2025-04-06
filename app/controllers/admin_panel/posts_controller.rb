module AdminPanel
  class PostsController < ApplicationController
    layout "admin_panel"
    def index
      filters = params.to_unsafe_h.slice(:search, :visibility, :from_date, :to_date)
      @posts = Post.published
                   .filter_records(filters)
                   .order(publication_date: :desc)
                   .page(params[:page])
    end
    def show
      @post = Post.find_by(id: params[:id])
      unless @post
        flash[:alert] = "Post nije pronađen."
        redirect_to admin_panel_posts_path
      end
    end
  end
end
