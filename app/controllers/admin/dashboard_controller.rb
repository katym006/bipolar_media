module Admin
  class DashboardController < BaseController
    def show
      @articles = Article.order(created_at: :desc).limit(10)
      @screening_tests = ScreeningTest.order(created_at: :desc).limit(10)
      @specialists = Specialist.includes(:city).order(created_at: :desc).limit(10)

      @articles_count = Article.count
      @screening_tests_count = ScreeningTest.count
      @specialists_count = Specialist.count
    end
  end
end
