require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task[name]", with: "new_task_name"
        fill_in "task[content]", with: "new_task_content"
        click_on("登録する")
        expect(page).to have_content '登録しました'
      end
    end
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '終了期限も登録できる' do
        visit new_task_path
        fill_in "task[name]", with: "new_task_name"
        fill_in "task[content]", with: "new_task_content"
        # binding.irb
        fill_in "task[deadline]", with: "00190001010000"
        click_on("登録する")
        # binding.irb
        expect(page).to have_content '1900/01/01 00:00'
      end
    end
  end


  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # task_old = FactoryBot.create(:task, name:'test_task_name_old')
        # task_new = FactoryBot.create(:task, name:'test_task_name_new')
        task_old = FactoryBot.create(:task)
        task_new = FactoryBot.create(:second_task)
        visit tasks_path
        all('tr td')[7].click_on '詳細'
        
        expect(page).to have_content 'test_task_name'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面で「終了期限でソートする」をクリックした場合' do
      it '終了期限で降順でソートされたタスク一覧が表示される' do
        # task_old = FactoryBot.create(:task, name:'test_task_name_deadline_old', deadline:'1900/01/01')
        # task_new = FactoryBot.create(:task, name:'test_task_name_deadline_new', deadline:'1900/02/01')
        task_old = FactoryBot.create(:task, name:'test_task_name_deadline_old')
        sleep 10
        task_new = FactoryBot.create(:second_task, name:'test_task_name_deadline_new')
        visit tasks_path
        click_on("終了期限でソートする")
        all('tr td')[7].click_on '詳細'
        expect(page).to have_content '2010/01/01 18:00'
        visit tasks_path
        click_on("終了期限でソートする")
        sleep 1
        all('tr td')[17].click_on '詳細'
        expect(page).to have_content '2000/01/01 18:00'
      end
    end

    context '一覧画面の検索エリアで「タスク名」を入力して「検索」ボタンを押下した場合場合' do
      it 'タスク名のあいまい検索で絞り込まれたタスク一覧が表示される' do
        # task_old = FactoryBot.create(:task, name:'test_task_name_deadline_old', deadline:'1900/01/01')
        # task_new = FactoryBot.create(:task, name:'test_task_name_deadline_new', deadline:'1900/02/01')
        task_old = FactoryBot.create(:task, name:'test_task_name_deadline_old')
        task_new = FactoryBot.create(:second_task, name:'test_task_name_search_result')
        visit tasks_path
        fill_in "search[name]", with: "search"
        click_on("検索")
        all('tr td')[7].click_on '詳細'
        expect(page).to have_content 'test_task_name_search_result'
      end
    end

    context '一覧画面の検索エリアで「ステータス」を入力して「検索」ボタンを押下した場合場合' do
      it 'ステータスで絞り込まれたタスク一覧が表示される' do
        # task_old = FactoryBot.create(:task, name:'test_task_name_deadline_old', deadline:'1900/01/01')
        # task_new = FactoryBot.create(:task, name:'test_task_name_deadline_new', deadline:'1900/02/01')
        task_old = FactoryBot.create(:task, name:'test_task_name_status_working')
        task_new = FactoryBot.create(:second_task, name:'test_task_name_status_waiting')
        visit tasks_path
        select '着手中',from:'search[status]'
        click_on("検索")
        all('tr td')[7].click_on '詳細'
        expect(page).to have_content 'test_task_name_status_working'
      end
    end
    context '一覧画面の検索エリアで「タスク名」と「ステータス」を入力して「検索」ボタンを押下した場合場合' do
      it 'タスク名とステータスで絞り込まれたタスク一覧が表示される' do
        # task_old = FactoryBot.create(:task, name:'test_task_name_deadline_old', deadline:'1900/01/01')
        # task_new = FactoryBot.create(:task, name:'test_task_name_deadline_new', deadline:'1900/02/01')
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

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        visit new_task_path
        fill_in "task[name]", with: "detail_task_name"
        fill_in "task[content]", with: "detail_task_content"
        click_on("登録する")
        click_on("詳細")
        expect(page).to have_content 'detail_task_name'
       end
     end
  end
end

# require 'rails_helper'
# describe 'タスク管理機能', type: :system do
#   describe '一覧表示機能' do
#     context '一覧画面に遷移した場合' do
#       it '作成済みのタスク一覧が表示される' do
#       # テストで使用するためのタスクを作成
#         task = FactoryBot.create(:task, name: 'task')
#         # タスク一覧ページに遷移
#         visit tasks_path
#         # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
#         # have_contentされているか。（含まれているか。）ということをexpectする（確認・期待する）
#         # expect(page).to have_content 'task'
#         # わざと間違った結果を期待するテストを記載する
#         expect(page).to have_content 'task_failure'
#         # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
#       end
#     end
#   end
# end