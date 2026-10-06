class ScreeningTestsController < ApplicationController
  def index
    @screening_tests = ScreeningTest.all
  end

  def show
    @screening_test = ScreeningTest.find(params[:id])
    @questions = @screening_test.test_questions.order(:position)
  end
end
