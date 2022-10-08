class Purchase < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true, on: :create
  validates :date, presence: true, on: :create
  validates :amount, presence: true, numericality: { greater_than: 0 }, on: :create
  validates :country_of_purchase, presence: true, on: :create
  validates :counted, inclusion: { in: [true, false] }, on: :create
  validates :processed_for_points, inclusion: { in: [true, false] }, on: :create
  validates :checked_for_5_percent_rewards, inclusion: { in: [true, false] }, on: :create
  validates :checked_for_free_movie_tickets, inclusion: { in: [true, false] }, on: :create
end
