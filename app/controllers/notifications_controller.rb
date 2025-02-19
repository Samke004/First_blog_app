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
    case notification.notifiable
    when Comment
      post_path(notification.notifiable.post, anchor: "comment-#{notification.notifiable.id}")
    when Relationship
      user_path(notification.notifiable.follower)
    else
      root_path
    end
  end
end
