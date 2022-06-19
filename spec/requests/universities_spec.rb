require 'rails_helper'

RSpec.describe "Universities", type: :request do
  describe "GET #index" do
    it 'ステータス200を返すこと' do
      get universities_path
      expect(response).to have_http_status(200)
    end
  end
end
