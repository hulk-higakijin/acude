class Chatroom < ApplicationRecord
  belongs_to :professor
  belongs_to :candidate
  has_many :messages
end
