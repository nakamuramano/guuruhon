class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  has_one_attached :profile_image

  def get_profile_image(width,height)
      unless profile_image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpeg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      profile_image.variant(resize_to_limit: [width,height]).processed
  end

  def active_for_authentication?
    super && (is_active == true)
  end


  def own?(object)
    id == object.user_id
  end

  def bookmark(article)
    bookmarks_article << article
  end

  def unbookmark(article)
    bookmarks_articles.delete(article)
  end

  def bookmark?(article)
    bookmarks_articles.include?(article)
  end

end
