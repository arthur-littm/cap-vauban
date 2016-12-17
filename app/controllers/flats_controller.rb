class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :authenticate_admin!, except: [:index, :show]

  def index
    @flats = Flat.all
    @bookings = Booking.all.where(status: "confirmed")
  end

  def show
    @flat = Flat.find(params[:id])
    @bookings = Booking.where(flat: @flat).where(status: "confirmed")
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
    params.require(:flat).permit(:title, :description, :description_english, :description_italian, :capacity, :bathroom, :toilet, :bedrooms, :beds, :banner_photo, carousel_photos: [], photos: [])
  end
end
