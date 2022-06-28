class Professor < ApplicationRecord
  belongs_to :account
  has_many :chatrooms
  has_many :researches
  has_many :professor_faculities
  has_many :faculties, through: :professor_faculities
  has_many :recruitments

  before_create :check_account
  before_create :update_status

  private

    def check_account
      raise StandardError, 'すでにユーザータイプが設定されています' unless account.unidentified?
    end

    def update_status
      account.professor!
    end
end
