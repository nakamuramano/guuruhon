class ArticleTag < ApplicationRecord
  
# association  
  belongs_to :article
  belongs_to :tag
  
# validation  
  validates :article_id, presence: true
  validates :tag_id, presence: true

end
