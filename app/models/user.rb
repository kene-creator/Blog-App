class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable
  has_many :comments, foreign_key: 'author_id_id'
  has_many :posts, foreign_key: 'author_id_id'
  has_many :likes, foreign_key: 'author_id_id'

  # validations
  validates :email, presence: true
  validates :encrypted_password, presence: true

  ROLES = %w[admin default].freeze

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
