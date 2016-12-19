class SuggestionsController < ApplicationController
  before_action :authenticate_admin!, except: [:index]

  def new
    @suggestion = Suggestion.new
  end

  def create
    @suggestion = Suggestion.new(suggestion_params)
    if @suggestion.save
      redirect_to suggestions_path
    else
      render :new, alert: "Something went wrong!"
    end
  end

  def index
    @suggestions = Suggestion.all
  end

  def edit
    @suggestion = Suggestion.find(params[:id])
  end

  def update
    @suggestion = Suggestion.find(params[:id])
    if @suggestion.update(suggestion_params)
      redirect_to suggestion_path(@suggestion), notice: 'Suggestion mise a jour'
    else
      render :edit
    end
  end

  def destroy
    @suggestion = Suggestion.find(params[:id])
    if @suggestion.destroy
      redirect_to suggestions_path
    else
      redirect_to suggestions_path, alert: "Something went wrong!"
    end
  end

  private

  def suggestion_params
    params.require(:suggestion).permit(:title, :content, :content_english, :content_italian, :address, :link, :photo)
  end
end
