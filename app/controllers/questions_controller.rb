class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] 
  before_action :find_question,
                  only: [:edit, :destroy, 
                        :update, :vote_up, :vote_down]

   def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    # @question = Question.new(question_attributes)
    # @question.user = current_user
    @question      = current_user.questions.new(
                                      question_attributes)

    if @question.save
      redirect_to questions_path, notice: "Your question was created successfully!"
    else
      flash.now[:alert] = "Please correct the form"
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer   = Answer.new
    @favorite = current_user.favorite_for(@question)
    @vote     = current_user.vote_for(@question) || Vote.new
    @answers  = @question.answers.ordered_by_creation
  end

  def edit
  end

  def update
    if @question.update_attributes(question_attributes)
      redirect_to @question, notice: "Question updated successfully!"
    else
      flash.now[:alert] = "Couldn't update!"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to questions_path, notice: "Question deleted successfully!"
    else
      redirect_to questions_path, alert: "We had trouble deleting"
    end
  end

  private

  def question_attributes
    params.require(:question).permit([:title, :description, {category_ids: []}])
  end

  def find_question
    @question = current_user.questions.find_by_id(params[:id]) 
    redirect_to root_path, alert: "Access Denied" unless @question
  end

end