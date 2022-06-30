require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET #show" do
    before do
      @account = create(:account)
      sign_in @account
      @account.create_candidate(name: 'hogehoge', introduction: 'foobar!')
    end

    it 'ステータス200を返すこと' do
      get profile_path
      expect(response).to have_http_status(200)
    end

    # 未ログイン時：アクセスできない。
    # ログイン時：アクセスできる。表示されるのは自分の名前
  end

  describe "GET #new" do
    context '未ログイン時' do
      it 'ログインページにリダイレクトされること' do
        get new_profile_path
        expect(response).to redirect_to new_account_session_path
      end
    end

    context 'ログインアカウントがtype: unindentifiedのとき' do
      before do
        @account = create(:account)
        sign_in @account
      end

      it 'ステータス200を返すこと' do
        get new_profile_path
        expect(response).to have_http_status(200)
      end

      it '他のページにアクセスしてもこのページにリダイレクトされること' do
        get root_path
        expect(response).to redirect_to new_profile_path
      end
    end

    context 'ログインアカウントがtype: unindentifiedでないとき' do
      before do
        @account = create(:account)
        @account.candidate!
        sign_in @account
      end

      it 'ルートページにリダイレクトされること' do
        get new_profile_path
        expect(response).to redirect_to root_path
      end
    end
  end

end
