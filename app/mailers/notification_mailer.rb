class NotificationMailer < ApplicationMailer
    default from: 'no-reply@yourapp.com'
  
    def new_comment(comment)
      @comment = comment
      @post = comment.post
      @user = @post.user  # Vlasnik objave
  
      mail(
        to: @user.email,
        subject: "Novi komentar na #{@post.title}"
      )
    end
  
    def new_follower(followed_user, follower)
        @followed_user = followed_user  # Korisnik koji prima obavijest
        @follower = follower  # Korisnik koji je započeo praćenje
    
        mail(
          to: @followed_user.email,
          subject: "Novi pratitelj"
        )
    end
  end
  