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
        fill_in "task[deadline]", with: "1900/01/01"
        click_on("登録する")
        expect(page).to have_content '1900-01-01 00:00:00 +0900'
      end
    end
  end


  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task_old = FactoryBot.create(:task, name:'test_task_name_old')
        task_new = FactoryBot.create(:task, name:'test_task_name_new')
        visit tasks_path
        
        all('tr td')[7].click_on '詳細'
        
        expect(page).to have_content 'test_task_name_new'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面で「終了期限でソートする」をクリックした場合' do
      it '終了期限で降順でソートされたタスク一覧が表示される' do
        task_old = FactoryBot.create(:task, name:'test_task_name_deadline_old', deadline:'1900/01/01')
        task_new = FactoryBot.create(:task, name:'test_task_name_deadline_new', deadline:'1900/02/01')
        visit tasks_path
        click_on("終了期限でソートする")
        # binding.irb
        all('tr td')[7].click_on '詳細'
        expect(page).to have_content '1900-02-01 00:00:00 +0900'
        
        visit tasks_path
        click_on("終了期限でソートする")
        
        # binding.irb
        sleep 1
        all('tr td')[17].click_on '詳細'
        expect(page).to have_content '1900-01-01 00:00:00 +0900'
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