class Specialist < ApplicationRecord
  belongs_to :city
  validates :full_name, :specialty, :contacts, presence: true
end
