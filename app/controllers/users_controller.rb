class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :set_current_user, except: %i[show]

  def show
    @user = User.find(params[:id])
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: I18n.t('controllers.users.updated.success')
    else
      flash.now[:alert] = I18n.t('controllers.users.updated.failure')
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end

  def set_current_user
    @user = current_user
  end
end
