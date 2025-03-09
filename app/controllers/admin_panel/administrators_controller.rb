module AdminPanel
  class AdministratorsController < AdminPanel::BaseController
    def index
      @administrators = ::Admin.page(params[:page]).per(10) 
    end
  end
end
