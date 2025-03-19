class ReminderEmailJob < ApplicationJob
  queue_as :default

  def perform
    app_setting = AppSetting.instance

    User.find_each do |user|
      ReminderMailer.reminder_email(user, app_setting.reminder_email_text).deliver_later
    end

    self.class.set(wait: app_setting.remind_after_quantity.send(app_setting.remind_after_unit)).perform_later
  end
end
