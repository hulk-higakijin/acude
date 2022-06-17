class Account < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum status: { candidate: 0, professor: 1 } ## school_staff: 2, student:3を追加予定

  has_one :professor
  has_one :candidate
  has_many :messages
end
