class University < ApplicationRecord
  belongs_to :prefecture
  has_many :faculties

  scope :active, -> { where(active: true).includes(:prefecture).order(:prefecture_id) }
end
