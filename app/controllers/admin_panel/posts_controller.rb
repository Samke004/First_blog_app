module AdminPanel
  class PostsController < ApplicationController
    def index
      @posts = Post.published

      # Pretraga
      @posts = @posts.search_by_title_and_content(params[:search]) if params[:search].present?

      # Filtriranje prema vidljivosti
      @posts = @posts.filter_by_visibility(params[:visibility]) if params[:visibility].present?

      # Filtriranje prema datumu objave
      @posts = @posts.filter_by_date_range(params[:from_date], params[:to_date])

      # Paginacija i sortiranje
      @posts = @posts.order(publication_date: :desc).page(params[:page])
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
