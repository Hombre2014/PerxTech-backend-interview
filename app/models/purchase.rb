class Purchase < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true, on: :create
  validates :date, presence: true, on: :create
  validates :amount, presence: true, numericality: { greater_than: 0 }, on: :create
  validates :country_of_purchase, presence: true, on: :create
end
