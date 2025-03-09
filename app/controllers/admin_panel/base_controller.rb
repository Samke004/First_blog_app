module AdminPanel
  class BaseController < ApplicationController
    before_action :authenticate_admin!
    layout "admin_panel"
  end
end
