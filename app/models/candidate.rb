class Candidate < ApplicationRecord
  belongs_to :account
  has_many :chatrooms
  has_many :dreaming_faculties

  before_create :check_account
  before_create :update_status

  private

    def check_account
      raise StandardError, 'すでにユーザータイプが設定されています' unless account.unidentified?
    end

    def update_status
      account.candidate!
    end
end
