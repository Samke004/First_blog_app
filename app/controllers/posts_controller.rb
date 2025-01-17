class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user, only: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
  @user = User.find(params[:user_id])
  sort_order = params[:sort] == 'asc' ? :asc : :desc

  if @user == current_user
    @posts = @user.posts.order(publication_date: sort_order).page(params[:page]).per(5)
  elsif user_signed_in?
    @posts = @user.posts.published.order(publication_date: sort_order).page(params[:page]).per(5)
  else
    @posts = @user.posts.public_posts.order(publication_date: sort_order).page(params[:page]).per(5)
  end
end
  

  def show
    # Provjeri vidljivost
    unless @post.published? || @post.user == current_user
      redirect_to root_path, alert: "Nije dopušten pristup ovoj objavi."
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to user_posts_path(current_user), notice: "Objava uspješno kreirana."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to user_posts_path(current_user), notice: "Objava uspješno ažurirana."
    else
      render :edit
    end
  end
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  
    respond_to do |format|
      format.turbo_stream # Turbo Stream odgovor za dinamičko ažuriranje
      format.html { redirect_to user_posts_path(@post.user), notice: "Objava je uspešno obrisana." }
    end
  end
  
  
  
  
    
    

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user
    redirect_to root_path, alert: "Nemate dopuštenje za ovu akciju." unless @post.user == current_user
  end

  def post_params
    params.require(:post).permit(:title, :short_description, :content, :image, :publication_date, :public, :published)
  end
end
