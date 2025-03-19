class Admin::AppSettingsController < ApplicationController
  before_action :set_app_setting
  layout "admin_panel"
  def edit
  end

  def update
    if @app_setting.update(app_setting_params)
      redirect_to edit_admin_app_setting_path, notice: "Postavke su uspješno ažurirane."
    else
      render :edit
    end
  end

  private

  def set_app_setting
    @app_setting = AppSetting.instance
  end

  def app_setting_params
    params.require(:app_setting).permit(:remind_after_quantity, :remind_after_unit, :reminder_email_text)
  end
end
