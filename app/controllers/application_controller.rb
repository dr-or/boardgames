class ApplicationController < ActionController::Base
  include Pundit::Authorization

  helper_method :current_user_can_edit?

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [:name]
    )
  end

  private

  def current_user_can_edit?(model)
    user_signed_in? &&
      (model.user == current_user ||
        (model.try(:game).present? && model.game.user == current_user))
  end
end
