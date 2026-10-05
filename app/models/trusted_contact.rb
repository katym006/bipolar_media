class TrustedContact < ApplicationRecord
  belongs_to :profile
validates :name, :email, presence: true
end
