class Account < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum status: { unidentified: 0, candidate: 1, professor: 2 } ## school_staff: 3, student:4を追加予定

  has_one :professor
  has_one :candidate
  has_many :messages

  def profile
    if professor?
      professor
    elsif candidate?
      candidate
    end
  end
end
