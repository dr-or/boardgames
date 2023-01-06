class ApplicationController < ActionController::Base
  helper_method :current_user_can_edit?

  private

  def current_user_can_edit?(game)
    user_signed_in? && game.user == current_user
  end
end
