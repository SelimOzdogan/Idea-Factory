class Idea < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy

  belongs_to :user

  validates :title, {
    presence: true
  }
validates :description, {
    presence: true,
    length: { minimum: 10 },
  }
end
