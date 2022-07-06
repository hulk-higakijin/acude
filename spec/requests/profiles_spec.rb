require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET #show" do
    context '未ログイン時' do
      it 'ログインページにリダイレクトされること' do
        get profile_path
        expect(response).to redirect_to new_account_session_path
      end
    end

    describe 'ログイン時' do
      before do
        @account = create(:account)
        sign_in @account
      end

      context 'ログインアカウントがtype: :unindentifiedのとき' do
        it 'プロフィール作成ページにリダイレクトされること' do
          get profile_path
          expect(response).to redirect_to new_profile_path
        end
      end

      context 'ログインアカウントがtype: :professorのとき' do
        it 'ステータス200を返すこと' do
          @account.create_professor(name: 'ズワイガニ教授', introduction: 'ミシシッピ川からやってきたよ')
          get profile_path
          expect(response).to have_http_status(200)
        end

        it '自分の名前が表示されること' do
          @account.create_candidate(name: 'ズワイガニ教授', introduction: 'ミシシッピ川からやってきたよ')
          get profile_path
          expect(response.body).to include('ズワイガニ教授')
        end
      end

      context 'ログインアカウントがtype: :candidateのとき' do
        it 'ステータス200を返すこと' do
          @account.create_candidate(name: 'ニッポニア・ニッポン太郎', introduction: '我の正体はトキや')
          get profile_path
          expect(response).to have_http_status(200)
        end

        it '自分の名前が表示されること' do
          @account.create_candidate(name: 'ニッポニア・ニッポン太郎', introduction: '我の正体はトキや')
          get profile_path
          expect(response.body).to include('ニッポニア・ニッポン太郎')
        end
      end
    end
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

  describe "POST #create" do
    context "未ログイン時" do
      it '保存されないこと' do
        expect do
          post profile_path, params: { status: 'professor', profile: { name: 'ズワイガニ教授', introduction: 'ミシシッピ川からやってきたよ' }}
        end.to change { Professor.count }.by(0)
      end

      it 'ログインページにリダイレクトされること' do
        post profile_path, params: { status: 'professor', profile: { name: 'ズワイガニ教授', introduction: 'ミシシッピ川からやってきたよ' }}
        expect(response).to redirect_to new_account_session_path
      end
    end

    describe "ログイン時" do
      before do
        @account = create(:account)
        sign_in @account
      end

      context "ログインアカウントがtype: :unidentifiedのとき" do
        it 'Professorのレコードが1つ増える' do
          expect do
            post profile_path, params: { status: 'professor', profile: { name: 'ズワイガニ教授', introduction: 'ミシシッピ川からやってきたよ' }}
          end.to change { Professor.count }.from(0).to(1)
        end
      end
  
      context "ログインアカウントがtype: :unidentifiedでないとき" do
        it '保存されないこと' do
          @account.create_professor(name: 'ズワイガニ教授', introduction: 'ミシシッピ川からやってきたよ')
          expect do
            @account.create_candidate(name: 'ニッポニア・ニッポン太郎', introduction: '我の正体はトキや')
          end.to raise_error("すでにユーザータイプが設定されています")
        end
      end
    end
  end

  describe "GET #edit" do
    context "未ログイン時" do
      it 'ログインページにリダイレクトすること' do
      end
    end

    context "ログインアカウントがtype: :unidentifiedのとき" do
      it 'プロフィール作成ページにリダイレクトされること' do

      end
    end

    context "ログインアカウントのステータスが確定しているとき" do
      it 'ステータス200を返すこと' do
        # get edit_profile_path
        # expect(response).to have_http_status(200)
      end

      it '名前と紹介文が表示されていること' do
        
      end
    end
  end
end
