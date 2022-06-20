class University < ApplicationRecord
  belongs_to :prefecture
  has_many :faculties
  has_one_attached :icon
  has_one_attached :thumbnail

  default_scope { order(:prefecture_id) }
  scope :active, -> { where(active: true) }
  scope :result, ->(params) { active.where('name LIKE(?)', "%#{params[:name]}%") }
end
