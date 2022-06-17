class DreamingFaculty < ApplicationRecord
  belongs_to :faculty
  belongs_to :candidate
end
