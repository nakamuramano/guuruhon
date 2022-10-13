class Article < ApplicationRecord
  
# association
  belongs_to :user

  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  
  
# validation
  validates :title, presence: true, length: {maximum: 50}
  validates :content, presence: true, length: {maximum: 200}


  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてold_tagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags
    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end
    # 新しいタグを保存
    new_tags.each do |new|
      new_article_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_article_tag
   end
  end


 #既にブックマークしているか確認
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

end

