class Candidate < ApplicationRecord
  belongs_to :account
  has_many :chatrooms
  has_many :dreaming_faculties
end
