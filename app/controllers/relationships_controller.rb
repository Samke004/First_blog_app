class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])

    # Provjera postoji li već praćenje
    if current_user.following?(user)
      redirect_to user, alert: "Već pratite ovog korisnika."
    else
      current_user.follow(user)
      NotificationMailer.new_follower(user,current_user).deliver_later
      redirect_to user, notice: "Počeli ste pratiti korisnika."
    end
  end

  def destroy
    relationship = current_user.active_relationships.find(params[:id])
    user = relationship.followed
    current_user.unfollow(user)
    redirect_to user, notice: "Prestali ste pratiti korisnika."
  end
end
