class ProfessorFaculity < ApplicationRecord
  belongs_to :professor
  belongs_to :faculty
end
