class University < ApplicationRecord
  belongs_to :prefecture
  has_many :faculties
  has_one_attached :icon
  has_one_attached :thumbnail

  scope :active, -> { where(active: true).order(:prefecture_id) }
end
