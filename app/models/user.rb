class User < ApplicationRecord
  
  has_many :questions
  has_many :responses
  has_many :posted_responses, foreign_key: :responce_user_id, class_name: 'Response'
  has_many :posted_posts, foreign_key: :post_user_id, class_name: 'Post'
  has_many :posts
  has_many :groups
  has_many :comments
  has_many :votes

  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
