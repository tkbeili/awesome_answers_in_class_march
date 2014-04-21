class CommentsController < ApplicationController
  before_action :find_answer
  before_action :authenticate_user!

  def create
    @comment = @answer.comments.new(params.require(:comment).permit(:body))
    if @comment.save
      redirect_to @answer.question
    else
      flash.now[:alert] = "comment wasn't created"
      render "questions/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!
    redirect_to @answer.question, notice: "Comment deleted successfully!"
  end

  private

  def find_answer
    @answer  = Answer.find(params[:answer_id])
  end

end