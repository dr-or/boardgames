class PhotosController < ApplicationController
  before_action :set_game, only: %i[create destroy]
  before_action :set_photo, only: %i[destroy]

  def create
    @new_photo = @game.photos.build(photo_params)
    @new_photo.user = current_user

    if @new_photo.save
      MailingJob.perform_later(@new_photo)
      redirect_to game_path(@game), notice: I18n.t('controllers.photos.created')
    else
      flash.now[:alert] = I18n.t('controllers.error')
      render 'games/show'
    end
  end

  def destroy
    message = { notice: I18n.t('controllers.photos.destroyed') }

    if current_user_can_edit?(@photo)
      @photo.destroy
    else
      message = { alert: I18n.t('controllers.error') }
    end

    redirect_to game_path(@game), message
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_photo
    @photo = @game.photos.find(params[:id])
  end

  def photo_params
    params.fetch(:photo, {}).permit(:photo)
  end
end
