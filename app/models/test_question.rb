class TestQuestion < ApplicationRecord
  belongs_to :screening_test

validates :text, presence: true
validates :position,
          numericality: { only_integer: true, greater_than: 0 },
          uniqueness: { scope: :screening_test_id }
end
