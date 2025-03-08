class NotificationJob < ApplicationJob
  queue_as :default

  def perform(notifiable, recipient)
    Notification.create!(
      recipient: recipient,
      notifiable: notifiable
    )
  end
end
