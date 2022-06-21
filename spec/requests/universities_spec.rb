require 'rails_helper'

RSpec.describe "Universities", type: :request do
  describe "GET #index" do
    it 'ステータス200を返すこと' do
      get universities_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    before do
      prefecture = create(:prefecture)
      @university = create(:university, name: "高崎未来総合大学", prefecture_id: prefecture.id, active: true)
    end

    it 'ステータス200を返すこと' do
      get university_path(@university)
      expect(response).to have_http_status(200)
    end
  end
end
