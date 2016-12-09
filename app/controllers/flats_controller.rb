class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @flats = Flat.all
  end

  def show
    @flat = Flat.find(params[:id])
  end

  def edit
    @flat = Flat.find(params[:id])
  end

  def update
    @flat = Flat.find(params[:id])
    if @flat.update(flat_params)
      redirect_to flat_path(@flat), notice: 'Appartement mis a jour'
    else
      render :edit
    end
  end

  private

  def flat_params
    params.require(:flat).permit(:title, :description, :capacity, :bathroom, :toilet, :banner_photo, photos: [])
  end
end
