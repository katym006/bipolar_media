class Article < ApplicationRecord
  belongs_to :author, class_name: "User", optional: true

    has_many :article_tags, dependent: :destroy
    has_many :tags, through: :article_tags
    has_many :recommendations, dependent: :destroy

    validates :title, :body, presence: true
    validates :content_kind, inclusion: { in: %w[post myth guide] }
    validates :audience, inclusion: { in: %w[patient relative both] }

    scope :published, -> {
    where("published_at <= ?", Time.current)
    }
end
