require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  describe 'ユーザ登録のテスト' do
    context 'ユーザを新規登録した場合' do
      it 'タスク一覧画面に遷移し、ユーザの登録が完了したメッセージが表示されること' do
        visit new_user_path
        fill_in "user[name]", with: "new_common_user_name"
        fill_in "user[email]", with: "common@sample.jp"
        fill_in "user[password]", with: "12345678"
        fill_in "user[password_confirmation]", with: "12345678"
        click_on("アカウント作成")
        expect(page).to have_content 'new_common_user_nameを登録しました'
      end
    end
  
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移すること' do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end
  end


  describe 'セッション機能のテスト' do
    context 'ログイン画面で' do
      it 'ログインできること' do
        commonUser = FactoryBot.create(:common_user)
        visit new_session_path
        fill_in "session[email]", with: "c01@sample.jp"
        fill_in "session[password]", with: "12345678"
        click_on("Log in")
        expect(page).to have_content 'commonUser01でログイン中'
      end
    end
    context 'ログイン後に遷移したタスク一覧ページから' do
      it '自分の詳細画面(マイページ)に飛べること' do
        commonUser = FactoryBot.create(:common_user)
        visit new_session_path
        fill_in "session[email]", with: "c01@sample.jp"
        fill_in "session[password]", with: "12345678"
        click_on("Log in")
        click_on("Profile")
        expect(page).to have_content 'commonUser01のページ'
      end
    end
    context '一般ユーザが他人の詳細画面に飛ぶと' do
      it 'タスク一覧画面に遷移すること' do
        commonUser = FactoryBot.create(:common_user)
        visit new_session_path
        fill_in "session[email]", with: "c01@sample.jp"
        fill_in "session[password]", with: "12345678"
        click_on("Log in")
        visit user_path('10')
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログイン中のユーザが' do
      it 'ログアウトできること' do
        commonUser = FactoryBot.create(:common_user)
        visit new_session_path
        fill_in "session[email]", with: "c01@sample.jp"
        fill_in "session[password]", with: "12345678"
        click_on("Log in")
        click_on("Logout")
        expect(page).to have_content 'Log in'
      end
    end
  end

  describe '管理画面のテスト' do
    context '管理ユーザでログインした場合' do
      it '管理画面にアクセスできること' do
        adminUser = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "session[email]", with: "admin@sample.jp"
        fill_in "session[password]", with: "adminadmin"
        click_on("Log in")
        expect(page).to have_content 'ユーザ一覧'
      end
    end

    context '一般ユーザでログインした場合' do
      it '管理画面にアクセスしょうとすると、管理画面にアクセスできず自分のタスク一覧に遷移すること' do
        commonUser = FactoryBot.create(:common_user)
        visit new_session_path
        fill_in "session[email]", with: "c01@sample.jp"
        fill_in "session[password]", with: "12345678"
        click_on("Log in")
        visit admin_users_path
        expect(page).to have_content 'タスク一覧'
      end
    end

    context '管理ユーザでログインした場合' do
      it 'ユーザの新規作成ができること' do
        adminUser = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "session[email]", with: "admin@sample.jp"
        fill_in "session[password]", with: "adminadmin"
        click_on("Log in")
        click_on("新規アカウント作成")
        fill_in "user[name]", with: "new_common_user_name"
        fill_in "user[email]", with: "common@sample.jp"
        select '一般',from:'user[admin]'
        fill_in "user[password]", with: "12345678"
        fill_in "user[password_confirmation]", with: "12345678"
        click_on("アカウント作成")
        expect(page).to have_content 'new_common_user_nameを作成しました'
      end
    end

    context '管理ユーザでログインした場合' do
      it 'ユーザの詳細画面にアクセスできること' do
        commonUser = FactoryBot.create(:common_user)
        adminUser = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "session[email]", with: "admin@sample.jp"
        fill_in "session[password]", with: "adminadmin"
        click_on("Log in")
        all('tr td')[5].click_on '詳細'
        expect(page).to have_content 'commonUser01のプロフィール'
      end
    end
    context '管理ユーザでログインした場合' do
      it 'ユーザの編集画面からユーザを編集できること' do
        commonUser = FactoryBot.create(:common_user)
        adminUser = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "session[email]", with: "admin@sample.jp"
        fill_in "session[password]", with: "adminadmin"
        click_on("Log in")
        all('tr td')[6].click_on '編集'
        fill_in "user[name]", with: "edited_common_user_name"
        fill_in "user[email]", with: "edited_common@sample.jp"
        select '一般',from:'user[admin]'
        fill_in "user[password]", with: "1qazxsw2"
        fill_in "user[password_confirmation]", with: "1qazxsw2"
        click_on("アカウント修正")
        expect(page).to have_content 'edited_common_user_name'
      end
    end
    context '管理ユーザでログインした場合' do
      it 'ユーザの削除をできること' do
        commonUser = FactoryBot.create(:common_user)
        adminUser = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "session[email]", with: "admin@sample.jp"
        fill_in "session[password]", with: "adminadmin"
        click_on("Log in")
        all('tr td')[7].click_on '削除'
        page.accept_confirm "本当に削除してよろしいですか?"
        expect(page).to have_content 'アカウントcommonUser01を削除しました！'
      end
    end
  end
end