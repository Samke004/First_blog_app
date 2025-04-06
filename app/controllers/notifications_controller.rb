class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.recent
  end

  def show
    @notification = current_user.notifications.find(params[:id])
    @notification.mark_as_read!
    redirect_to notification_target(@notification)
  end

  private

  def notification_target(notification)
    return post_path(notification.notifiable.post, anchor: "comment-#{notification.notifiable.id}") if notification.notifiable.is_a?(Comment)
    return user_path(notification.notifiable.follower) if notification.notifiable.is_a?(Relationship)

    root_path
  end
end
