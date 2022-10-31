class User < ApplicationRecord
  has_many :facts
  validates :username, presence: true, length: {minimum: 4, maximum: 20}, uniqueness: true
  validates :password, presence: true, length: {minimum: 6, maximum: 20}
end
