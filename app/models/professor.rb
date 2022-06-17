class Professor < ApplicationRecord
  belongs_to :account
  has_many :chatrooms
  has_many :researches
  has_many :professor_faculities
  has_many :faculties, through: :professor_faculities
  has_many :recruitments
end
