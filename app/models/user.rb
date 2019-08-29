class User < ApplicationRecord

  validates :name, presence: true
  validates :gender, presence: true
  belongs_to :user, optional: true
  def chats
    Chat.where('sender_id = ? or reciver_id = ?', id, id)
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
