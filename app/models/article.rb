class Article < ApplicationRecord
  has_many :article_tags,dependent: :destroy
  has_many :tags,through: :article_tags

  validates :title, presence: true
  validates :content, presence: true

  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy


  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete　Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_article_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_article_tag
   end
  end

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end






end




