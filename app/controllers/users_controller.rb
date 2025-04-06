class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :following, :followers, :update ]
  before_action :set_user, only: [ :show, :following, :followers, :update ]
  before_action :check_permissions, only: [ :update ]

  def index
    @users = User.order(:first_name).page(params[:page]).per(10) # Dodana paginacija i sortiranje
  end

  def show
  end

  def following
    @title = "Praćenje"
    @users = @user.following.page(params[:page]).per(10)
    render "show_follow"
  end

  def followers
    @title = "Pratitelji"
    @users = @user.followers.page(params[:page]).per(10)
    render "show_follow"
  end

  def create
    @user = User.new(user_params)

    if @user.save
      Rails.logger.info "📢 Novi korisnik registriran: ID=#{@user.id}, IP=#{request.remote_ip}" # LOG
      fetch_country_for(@user) # Dohvati državu nakon registracije
      Rails.logger.info "🌍 Zemlja korisnika nakon registracije: #{@user.reload.country}" # LOG

      flash[:notice] = "Korisnik je uspješno registriran."
      redirect_to @user
    else
      flash[:alert] = "Greška prilikom registracije."
      render :new
    end
  end

  def update
    if @user.update(user_params)
      fetch_country_if_needed # Dohvati državu ako još nije postavljena
      flash[:notice] = "Profil uspješno ažuriran"
      redirect_to request.referer || edit_user_path(@user)
    else
      flash[:alert] = "Nije moguće ažurirati korisnika"
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_permissions
    unless current_user == @user || (current_user.respond_to?(:admin?) && current_user.admin?)
      flash[:alert] = "Nemate dozvolu za uređivanje ovog korisnika."
      redirect_to root_path
    end
  end

  def fetch_country_if_needed
    if @user.country.blank? && request.remote_ip.present?
      fetch_country_for(@user)
    end
  end

  def fetch_country_for(user)
    ip_address = request.env["HTTP_X_FORWARDED_FOR"]&.split(",")&.first || request.remote_ip
    ip_address ||= "8.8.8.8"
    Rails.logger.info "📢 IP adresa za korisnika #{user.id}: #{ip_address}" # Log IP adrese
    user.fetch_country_from_ip(ip_address)
    Rails.logger.info "🌍 Zemlja korisnika #{user.id}: #{user.reload.country}" # Log rezultata
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :country,
                                 contact_emails_attributes: [ :id, :email, :_destroy ])
  end
end
