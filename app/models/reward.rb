class Reward < ApplicationRecord
  validates :user_id, presence: true, on: :create
  validates :name, presence: true, on: :create

  belongs_to :user
end
