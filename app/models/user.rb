class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: {minimum:1}
  validates :last_name, presence: true, length: {minimum:1}
  validates :address, presence: true, length: { minimum: 10 }
  validates :birthday, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_username,
    against: [ :username ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :response_sets
  has_many :answers, through: :response_sets
  has_many :questions, through: :response_sets
  has_one_attached :profile_photo
  has_many :orders
  has_many :ratings
  has_recommended :products

  def pending_orders
    self.orders.is_pending
  end
end
