class TestAttempt < ApplicationRecord
  belongs_to :user
  belongs_to :screening_test

  has_many :recommendations, dependent: :destroy
  has_many :articles, through: :recommendations
end
