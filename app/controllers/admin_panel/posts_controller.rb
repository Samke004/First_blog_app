module AdminPanel
  class PostsController < AdminPanel::BaseController
    def index
      @posts = Post.page(params[:page]).per(10) # Paginacija - 10 objava po stranici
    end

    def show
      @post = Post.find_by(id: params[:id]) # Koristimo `find_by` umjesto `find` kako bismo izbjegli grešku ako post ne postoji

      if @post.nil?
        redirect_to admin_panel_posts_path, alert: "Objava nije pronađena."
      end
    end
  end
end