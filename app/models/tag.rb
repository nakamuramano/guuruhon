class Tag < ApplicationRecord
  has_many :article_tags,dependent: :destroy, foreign_key: 'tag_id'
  has_many :articles,through: :article_tags

  validates :tag_name, uniqueness: true, presence: true
end
