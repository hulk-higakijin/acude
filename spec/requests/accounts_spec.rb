require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  describe "GET #new" do
    context '未ログイン時' do
      it 'ログインページにリダイレクトされること' do
        get new_account_path
        expect(response).to redirect_to new_account_session_path
      end
    end

    context 'ログインアカウントがtype: unindentifiedのとき' do
      before do
        @account = create(:account)
        sign_in @account
      end

      it 'ステータス200を返すこと' do
        get new_account_path
        expect(response).to have_http_status(200)
      end

      it '他のページにアクセスしてもこのページにリダイレクトされることsarerukoto' do
        get root_path
        expect(response).to redirect_to new_account_path
      end
    end

    context 'ログインアカウントがtype: unindentifiedでないとき' do
      before do
        @account = create(:account)
        @account.candidate!
        sign_in @account
      end

      it 'ルートページにリダイレクトされること' do
        get new_account_path
        expect(response).to redirect_to root_path
      end
    end
  end

end
