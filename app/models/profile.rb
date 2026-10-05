class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :city, optional: true

has_many :trusted_contacts, dependent: :destroy
has_many :mood_entries, dependent: :destroy

validates :user_id, uniqueness: true
validates :display_name, presence: true
end
