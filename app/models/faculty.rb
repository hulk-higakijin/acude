class Faculty < ApplicationRecord
  belongs_to :university
  has_many :researches
  has_many :professor_faculities
  has_many :professors, through: :professor_faculities
  has_many :recruitments
  has_many :dreaming_faculties
end
