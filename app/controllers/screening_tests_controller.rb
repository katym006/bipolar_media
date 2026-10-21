class ScreeningTestsController < ApplicationController
  include Paginatable

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_screening_test, only: %i[show edit update destroy]

  def index
    screening_tests = ScreeningTest.order(created_at: :desc)

    query = params[:q].to_s.strip
    if query.present?
      pattern = "%#{ScreeningTest.sanitize_sql_like(query)}%"
      screening_tests = screening_tests.where(
        "screening_tests.title LIKE :query OR screening_tests.description LIKE :query",
        query: pattern
      )
    end

    if %w[screening self_check].include?(params[:kind])
      screening_tests = screening_tests.where(kind: params[:kind])
    end

    @screening_tests = paginate(screening_tests)
  end

  def show
    @questions = @screening_test.test_questions.order(:position)
  end

  def new
    @screening_test = ScreeningTest.new
    authorize! :create, @screening_test
  end

  def create
    @screening_test = ScreeningTest.new(screening_test_params)
    authorize! :create, @screening_test

    if @screening_test.save
      redirect_to @screening_test, notice: "Тест создан"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @screening_test
  end

  def update
    authorize! :update, @screening_test

    if @screening_test.update(screening_test_params)
      redirect_to @screening_test, notice: "Тест обновлён"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @screening_test
    if @screening_test.destroy
      redirect_to screening_tests_path, notice: "Тест удалён"
    else
      redirect_to @screening_test, alert: @screening_test.errors.full_messages.to_sentence
    end
  end

  private

  def set_screening_test
    @screening_test = ScreeningTest.find(params[:id])
  end

  def screening_test_params
    params.require(:screening_test).permit(:title, :description, :kind)
  end
end
