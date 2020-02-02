class AdminsBackoffice::QuestionsController < AdminsBackofficeController
before_action :set_question, only: [:edit, :update, :destroy]
before_action :set_subjects, except: [:index, :delete]

  def index
    @questions = Question.includes(:subject).order(:subject_id, :id)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params_question)
    if @question.save # caso crie question, voltar para a tabela de quest. e exibir mensagem
      redirect_to admins_backoffice_questions_path, notice: "Questão criada com sucesso."
    else #caso não, voltar para a página de criação (pág. atual)
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(params_question) # caso haja atualização, voltar para a tabela de adm e exibir mensagem
      redirect_to admins_backoffice_questions_path, notice: "Questão atualizada com sucesso."
    else #caso não consiga edição, voltar para a página edit (pág. atual)
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to admins_backoffice_questions_path, notice: "Questão excluída com sucesso."
    else #caso não consiga edição, voltar para a página edit (pág. atual)
      render :index
    end
  end

  private
  def set_subjects
    @subjects = Subject.all
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def params_question
    params.require(:question).permit(:description, :subject_id,
      answers_attributes: [:id, :description, :correct, :_destroy])
  end
end