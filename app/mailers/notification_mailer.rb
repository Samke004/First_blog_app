class NotificationMailer < ApplicationMailer
  default from: 'no-reply@yourapp.com'

  def new_comment(comment)
    @comment = comment
    @post = comment.post
    @user = @post.user  

    mail(
      to: @user.email,
      subject: "Novi komentar na #{@post.title}"
    )
  end

  def new_follower(followed_user, follower)
    @followed_user = followed_user  
    @follower = follower  

    mail(
      to: @followed_user.email,
      subject: "Novi pratitelj"
    )
  end

  def reminder_email(user)
    @user = user
    @app_setting = AppSetting.instance  
    @reminder_text = @app_setting.reminder_email_text  

    mail(
      to: @user.email,
      subject: "Nedostajete nam!",
      body: @reminder_text  
    )
  end
end
