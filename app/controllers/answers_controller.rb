class AnswersController < QuestionsController
  before_action :find_question

  def create
    @answer      = @question.answers.new(answer_attributes)
    @answer.user = current_user

    respond_to do |format|
      if @answer.save
        # AnswerMailer.notify_question_owner(@answer).deliver
        AnswerMailer.delay.notify_question_owner(@answer)
        format.html { redirect_to @question, notice: "Answer created successfully!" }
        format.js   { render }
      else
        format.html { render "/questions/show" }
        format.js   { render :new }
      end
    end
  end

  def destroy
    @answer   = @question.answers.find(params[:id])
    respond_to do |format|
      if @answer.user == current_user && @answer.destroy
        format.html { redirect_to @question, notice: "Answer deleted"}
        format.js   { render }
      else
        format.html { redirect_to @question, alert: "We had trouble deleting the answer"}
        format.js   { render } 
      end
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