class Recommendation < ApplicationRecord
  belongs_to :test_attempt
  belongs_to :article
  validates :article_id, uniqueness: { scope: :test_attempt_id }
end
