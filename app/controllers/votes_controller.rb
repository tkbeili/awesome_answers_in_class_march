class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question

  def create
    @vote      = @question.votes.new(vote_params)
    @vote.user = current_user
    if @vote.save
      redirect_to @question, notice: "Thanks for voting!"
    else
      redirect_to @question, alert: "Your vote wasn't recorded!"
    end
  end

  def update
    @vote = current_user.votes.find(params[:id])
    if @vote.update_attributes(vote_params)
      redirect_to @question, notice: "Vote updated!"
    else
      redirect_to @question, notice: "Vote wasn't updated!"
    end
  end

  def destroy
    @vote = current_user.votes.find(params[:id])
    if @vote.destroy
      redirect_to @question, notice: "Vote removed"
    else
      redirect_to @question, alert: "Vote couldn't be removed"
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end

  def find_question
    @question  = Question.find(params[:question_id])
  end

end