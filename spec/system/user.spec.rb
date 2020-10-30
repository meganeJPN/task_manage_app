require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  describe 'ユーザ登録のテスト' do
    context 'ユーザを新規登録した場合' do
      it '作成したユーザが表示される' do
        visit new_task_path
        fill_in "task[name]", with: "new_task_name"
        fill_in "task[content]", with: "new_task_content"
        fill_in "task[deadline]", with: "00190001010000"
        click_on("登録する")
        expect(page).to have_content '登録しました'
      end
    end
  
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移すること' do
        visit new_task_path
        fill_in "task[name]", with: "new_task_name"
        fill_in "task[content]", with: "new_task_content"
        fill_in "task[deadline]", with: "00190001010000"
        click_on("登録する")
        expect(page).to have_content '1900/01/01 00:00'
      end
    end
  end


  describe 'セッション機能のテスト' do
    context 'ログイン画面で' do
      it 'ログインできること' do
        task_old = FactoryBot.create(:task)
        task_new = FactoryBot.create(:second_task)
        visit tasks_path
        all('tr td')[7].click_on '詳細'
        
        expect(page).to have_content 'test_task_name'
      end
    end
    context 'ログイン後に遷移したタスク一覧ページから' do
      it '自分の詳細画面(マイページ)に飛べること' do
        task_old = FactoryBot.create(:task)
        task_new = FactoryBot.create(:second_task)
        visit tasks_path
        all('tr td')[7].click_on '詳細'
        
        expect(page).to have_content 'test_task_name'
      end
    end
    context '一般ユーザが他人の詳細画面に飛ぶと' do
      it 'タスク一覧画面に遷移すること' do
        task_old = FactoryBot.create(:task)
        task_new = FactoryBot.create(:second_task)
        visit tasks_path
        all('tr td')[7].click_on '詳細'
        
        expect(page).to have_content 'test_task_name'
      end
    end
    context 'ログイン中のユーザが' do
      it 'ログアウトできること' do
        task_old = FactoryBot.create(:task)
        task_new = FactoryBot.create(:second_task)
        visit tasks_path
        all('tr td')[7].click_on '詳細'
        
        expect(page).to have_content 'test_task_name'
      end
    end
  end

  describe '管理画面のテスト' do
    context '管理ユーザでログインした場合' do
      it '管理画面にアクセスできること' do
        task_old = FactoryBot.create(:task, name:'test_task_name_deadline_old')
        task_new = FactoryBot.create(:second_task, name:'test_task_name_deadline_new')
        visit tasks_path
        click_on("終了期限▼")
        sleep 1
        all('tr td')[7].click_on '詳細'
        expect(page).to have_content '2010/01/01 18:00'
        visit tasks_path
        click_on("終了期限▼")
        sleep 1
        all('tr td')[17].click_on '詳細'
        expect(page).to have_content '2000/01/01 18:00'
      end
    end

    context '一般ユーザでログインした場合' do
      it '管理画面にアクセスしょうとすると、管理画面にアクセスできず自分のタスク一覧に遷移すること' do
        task_middle = FactoryBot.create(:task, name:'test_task_name_priority_middle',priority:'middle')
        task_low = FactoryBot.create(:second_task, name:'test_task_name_priority_low',priority:'low')
        task_high = FactoryBot.create(:third_task, name:'test_task_name_priority_high',priority:'high')
        visit tasks_path
        click_on("優先順位▼")
        sleep 1
        all('tr td')[7].click_on '詳細'
        expect(page).to have_content '高'
        visit tasks_path
        click_on("優先順位▼")
        sleep 1
        all('tr td')[17].click_on '詳細'
        expect(page).to have_content '中'
        visit tasks_path
        click_on("優先順位▼")
        sleep 1
        all('tr td')[27].click_on '詳細'
        expect(page).to have_content '低'
      end
    end

    context '管理ユーザでログインした場合' do
      it 'ユーザの新規作成ができること' do
        task_old = FactoryBot.create(:task, name:'test_task_name_deadline_old')
        task_new = FactoryBot.create(:second_task, name:'test_task_name_search_result')
        visit tasks_path
        fill_in "search[name]", with: "search"
        click_on("検索")
        all('tr td')[7].click_on '詳細'
        expect(page).to have_content 'test_task_name_search_result'
      end
    end

    context '管理ユーザでログインした場合' do
      it 'ユーザの詳細画面にアクセスできること' do
        task_old = FactoryBot.create(:task, name:'test_task_name_status_working')
        task_new = FactoryBot.create(:second_task, name:'test_task_name_status_waiting')
        visit tasks_path
        select '着手中',from:'search[status]'
        click_on("検索")
        all('tr td')[7].click_on '詳細'
        expect(page).to have_content 'test_task_name_status_working'
      end
    end
    context '管理ユーザでログインした場合' do
      it 'ユーザの編集画面からユーザを編集できること' do
        task_first = FactoryBot.create(:task, name:'test_task_name_status_working')
        task_second = FactoryBot.create(:second_task, name:'test_task_name_result')
        task_third = FactoryBot.create(:third_task, name:'test_task_name_status_waiting')
        visit tasks_path
        fill_in "search[name]", with: "res"
        select '未着手',from:'search[status]'
        click_on("検索")
        expect(page).to_not have_content 'test_task_name_status_waiting'
        expect(page).to have_content 'test_task_name_result'
      end
    end
    context '管理ユーザでログインした場合' do
      it 'ユーザの削除をできること' do
        task_first = FactoryBot.create(:task, name:'test_task_name_status_working')
        task_second = FactoryBot.create(:second_task, name:'test_task_name_result')
        task_third = FactoryBot.create(:third_task, name:'test_task_name_status_waiting')
        visit tasks_path
        fill_in "search[name]", with: "res"
        select '未着手',from:'search[status]'
        click_on("検索")
        expect(page).to_not have_content 'test_task_name_status_waiting'
        expect(page).to have_content 'test_task_name_result'
      end
    end
  end
end