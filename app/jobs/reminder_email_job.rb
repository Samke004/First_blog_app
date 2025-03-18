class ReminderEmailJob < ApplicationJob
  queue_as :default

  def perform
    users = User.where("last_seen_at <= ? AND (reminder_email_sent_at IS NULL OR reminder_email_sent_at <= ?)", 
                        30.days.ago, 30.days.ago)

    users.each do |user|
      NotificationMailer.reminder_email(user).deliver_now
      user.update_column(:reminder_email_sent_at, Time.current) 
      
    end
  end
end
