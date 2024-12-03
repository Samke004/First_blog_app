class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user, only: [:edit, :update, :destroy]
    def show
        @post = Post.find(params[:id])
      end
      def index
        @user = User.find(params[:user_id])
        
        if @user == current_user
          @posts = @user.posts.order(publication_date: :desc).page(params[:page]).per(5)
        elsif user_signed_in?
          @posts = @user.posts.where(published: true).order(publication_date: :desc).page(params[:page]).per(5)
        else
          @posts = @user.posts.where(public: true, published: true).order(publication_date: :desc).page(params[:page]).per(5)
        end
      
        Rails.logger.debug("Loaded posts: #{@posts.map(&:title).inspect}") # Logiranje naslova objava
      end
  
    def new
      @post = current_user.posts.new
    end
  
    def create
      @post = current_user.posts.new(post_params)
      if @post.save
        redirect_to user_posts_path(current_user), notice: "Post successfully created."
      else
        render :new
      end
    end
  
    def edit; end
  
    def update
      if @post.update(post_params)
        redirect_to user_posts_path(current_user), notice: "Post successfully updated."
      else
        render :edit
      end
    end
  
    def destroy
      @post.destroy
      redirect_to user_posts_path(current_user), notice: "Post successfully deleted."
    end
  
    private
  
    def set_post
      @post = Post.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:title, :short_description, :content, :publication_date, :public, :published)
    end
  
    def authorize_user
      redirect_to root_path, alert: "You are not authorized to perform this action." unless @post.user == current_user
    end
  end
  