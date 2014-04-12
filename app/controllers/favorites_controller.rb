class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question

  def create
    @favorite = @question.favorites.new
    @favorite.user = current_user
    if @favorite.save
      redirect_to @question, notice: "Thank for favoriting"
    else
      redirect_to @question, alert: "Could Not Favorite"
    end
  end


  def destroy
    @favorite = current_user.favorites.find(params[:id])
    if @favorite.destroy
      redirect_to @question, notice: "You have unfavorited"
    else
      redirect_to @question, alert: "Couldn't unfavorite"
    end
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end
end