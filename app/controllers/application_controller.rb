class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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

  def user_not_authorized
    flash[:alert] = I18n.t("controllers.prohibition")
    redirect_back(fallback_location: root_path)
  end
end
