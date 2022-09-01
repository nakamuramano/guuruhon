class Article < ApplicationRecord
  has_many :article_tags,dependent: :destroy
  has_many :tags,through: :articles_tags

  validates :title, presence: true
  validates :content, presence: true

  def save_tags(tags)
    tag_list = tags.split(/[[:blank:]]+/)
    current_tags = self.tags.pluck(:tag_name)
    old_tags = current_tags - tag_list
    new_tags = tag_list - current_tags

    p current_tags

    old_tags.each do |old|
     self.tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_article_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_article_tag
    end

  end








end




