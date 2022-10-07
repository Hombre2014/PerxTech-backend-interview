class User < ApplicationRecord
  has_many :purchases, dependent: :destroy
  has_many :rewards, dependent: :destroy

  validates :first_name, presence: true, length: { maximum: 12 }, on: :create
  validates :last_name, presence: true, length: { maximum: 24 }, on: :create
  validates :birthday, presence: true, on: :create
  validates :country_of_origin, presence: true, on: :create
  validates :level, presence: true, numericality: { greater_than: 0, less_than: 3 }, on: :create
  validates :points, presence: true, numericality: { greater_than_or_equal_to: 0 }, on: :create
  validates :tier, presence: true, length: { maximum: 8 }, on: :create
  validates :birthday_reward, inclusion: { in: [true, false] }, on: :create
end
