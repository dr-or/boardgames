class ApplicationController < ActionController::Base
  helper_method :current_user_can_edit?

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [:name]
    )
  end

  private

  def current_user_can_edit?(game)
    user_signed_in? && game.user == current_user
  end
end
