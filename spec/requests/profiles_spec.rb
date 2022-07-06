require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:professor_params) {{ name: 'ズワイガニ教授', introduction: 'ミシシッピ川からやってきたよ' }}
  let(:candidate_params) {{ name: 'ニッポニア・ニッポン太郎', introduction: '我の正体はトキや' }}

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
          @account.create_professor(professor_params)
          get profile_path
          expect(response).to have_http_status(200)
        end

        it '自分の名前が表示されること' do
          @account.create_candidate(professor_params)
          get profile_path
          expect(response.body).to include('ズワイガニ教授')
        end
      end

      context 'ログインアカウントがtype: :candidateのとき' do
        it 'ステータス200を返すこと' do
          @account.create_candidate(candidate_params)
          get profile_path
          expect(response).to have_http_status(200)
        end

        it '自分の名前が表示されること' do
          @account.create_candidate(candidate_params)
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
          post profile_path, params: { status: 'professor', profile: professor_params}
        end.to change { Professor.count }.by(0)
      end

      it 'ログインページにリダイレクトされること' do
        post profile_path, params: { status: 'professor', profile: professor_params}
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
            post profile_path, params: { status: 'professor', profile: professor_params}
          end.to change { Professor.count }.from(0).to(1)
        end
      end
  
      context "ログインアカウントがtype: :unidentifiedでないとき" do
        it '保存されないこと' do
          @account.create_professor(professor_params)
          expect do
            @account.create_candidate(candidate_params)
          end.to raise_error("すでにユーザータイプが設定されています")
        end
      end
    end
  end

  describe "GET #edit" do
    context "未ログイン時" do
      it 'ログインページにリダイレクトすること' do
        get edit_profile_path
        expect(response).to redirect_to new_account_session_path
      end
    end

    context "ログインアカウントがtype: :unidentifiedのとき" do
      before do
        @account = create(:account)
        sign_in @account
      end

      it 'プロフィール作成ページにリダイレクトされること' do
        get edit_profile_path
        expect(response).to redirect_to new_profile_path
      end
    end

    context "ログインアカウントのステータスが確定しているとき" do
      before do
        @account = create(:account)
        sign_in @account
        @account.create_professor(professor_params)
      end

      it 'ステータス200を返すこと' do
        get edit_profile_path
        expect(response).to have_http_status(200)
      end

      it '名前と紹介文が表示されていること' do
        get edit_profile_path
        expect(response.body).to include @account.profile.name && @account.profile.introduction
      end
    end
  end

  describe "PUT #update" do
    context "未ログイン時" do
      it 'ログインページにリダイレクトすること' do
        put profile_path, params: { profile: professor_params }
        expect(response).to redirect_to new_account_session_path
      end
    end

    context "ログインアカウントがtype: :unidentifiedのとき" do
      before do 
        @account = create(:account)
        sign_in @account
      end

      it 'プロフィール作成ページにリダイレクトされること' do
        put profile_path, params: { profile:  professor_params }
        expect(response).to redirect_to new_profile_path
      end
    end

    context "ログインアカウントのステータスが確定しているとき" do
      before do 
        @account = create(:account)
        sign_in @account
        @account.create_professor(professor_params)
      end

      it 'プロフィールが更新されること' do
        expect do
          put profile_path, params: { profile: { name: 'イケメンなズワイガニ教授' }}
        end.to change { @account.profile.name }.from('ズワイガニ教授').to('イケメンなズワイガニ教授')
      end

      it 'Accountとステータスのレコード数が変化しないこと' do
        expect do
          put profile_path, params: { profile: { name: 'イケメンなズワイガニ教授' }}
        end.to change { Account.count }.by(0).and change { Professor.count}.by(0).and change { Candidate.count }.by(0)
      end
    end
  end
end
