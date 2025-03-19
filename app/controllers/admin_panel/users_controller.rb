module AdminPanel
  class UsersController < AdminPanel::BaseController
    layout 'admin_panel'
    def index
      @users = User.page(params[:page]).per(10)
    end

    def show
      @user = User.find(params[:id])
    end
  end
end
