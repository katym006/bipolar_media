class MoodEntry < ApplicationRecord
  belongs_to :profile

validates :entry_date, presence: true,
                       uniqueness: { scope: :profile_id }
validates :mood_level, :energy_level,
          numericality: { only_integer: true }
validates :sleep_hours,
          numericality: {
            greater_than_or_equal_to: 0,
            less_than_or_equal_to: 24
          }
end
