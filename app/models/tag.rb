class Tag < ApplicationRecord
  
  #association
  has_many :article_tags,dependent: :destroy, foreign_key: 'tag_id'
  has_many :articles,through: :article_tags

  # validation
  validates :tag_name, uniqueness: true, presence: true, length: {maximum: 20}


end
