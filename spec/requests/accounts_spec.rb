require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  describe "GET #new" do
    it 'ステータス200を返すこと' do
      get new_account_path
      expect(response).to have_http_status(200)
    end
  end
end
