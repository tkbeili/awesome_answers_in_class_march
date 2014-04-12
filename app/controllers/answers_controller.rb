class AnswersController < QuestionsController
  before_action :find_question

  def create
    @answer      = @question.answers.new(answer_attributes)
    @answer.user = current_user
    if @answer.save
      redirect_to @question, notice: "Answer created successfully!"
    else
      render "/questions/show"
    end
  end

  def destroy
    @answer   = @question.answers.find(params[:id])
    if @answer.user == current_user && @answer.destroy
      redirect_to @question, notice: "Answer deleted"
    else
      redirect_to @question, alert: "We had trouble deleting the answer"
    end
  end

  private

  def answer_attributes
    params.require(:answer).permit([:body])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

end