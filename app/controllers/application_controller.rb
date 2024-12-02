class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Devise: Permit additional parameters for sign_up and account_update
  def configure_permitted_parameters
    # Permit additional parameters for sign_up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    # Permit additional parameters for account_update, including nested attributes
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :first_name, :last_name, :profile_picture,
      contact_emails_attributes: [:id, :email, :_destroy] # Nested attributes
    ])
  end
end
