class ScreeningTest < ApplicationRecord
    has_many :test_questions, dependent: :destroy
has_many :test_attempts, dependent: :restrict_with_error

validates :title, presence: true
validates :kind, inclusion: { in: %w[screening self_check] }
end
