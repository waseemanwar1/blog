class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :title, presence: true

  def liked_by?(user)
    likes.exists?(user: user)
  end

  def like_count
    likes.size
  end

  def dis_like(user)
    likes.find_by(user: user).destroy
  end
end
