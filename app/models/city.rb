class City < ApplicationRecord
has_many :profiles, dependent: :nullify
has_many :specialists, dependent: :restrict_with_error

validates :name, presence: true, uniqueness: true
end
