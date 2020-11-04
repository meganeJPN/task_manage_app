require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        task_user = FactoryBot.create(:task_user)
        visit new_session_path
        fill_in "session[email]", with: "t01@sample.jp"
        fill_in "session[password]", with: "12345678"
        click_on("Log in")
        click_on("新規タスクの作成")
        fill_in "task[name]", with: "new_task_name"
        fill_in "task[content]", with: "new_task_content"
        fill_in "task[deadline]", with: "00190001010000"
        click_on("登録する")
        expect(page).to have_content '登録しました'
      end
    end
  
    context 'タスクを新規作成した場合' do
      it '終了期限も登録できる' do
        task_user = FactoryBot.create(:task_user)
        visit new_session_path
        fill_in "session[email]", with: "t01@sample.jp"
        fill_in "session[password]", with: "12345678"
        click_on("Log in")
        click_on("新規タスクの作成")
        fill_in "task[name]", with: "new_task_name"
        fill_in "task[content]", with: "new_task_content"
        fill_in "task[deadline]", with: "00190001010000"
        click_on("登録する")
        expect(page).to have_content '1900/01/01 00:00'
      end
    end

    context 'タスクを新規作成した場合' do
      it '優先順位も登録できる' do
        task_user = FactoryBot.create(:task_user)
        visit new_session_path
        fill_in "session[email]", with: "t01@sample.jp"
        fill_in "session[password]", with: "12345678"
        click_on("Log in")
        click_on("新規タスクの作成")
        fill_in "task[name]", with: "new_task_name"
        fill_in "task[content]", with: "new_task_content"
        select '中',from:'task[priority]'
        click_on("登録する")
        expect(page).to have_content '中'
      end
    end
  end


  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task_user = create_and_login(:task_user)
        task_old = FactoryBot.create(:task,user_id:task_user.id)
        task_new = FactoryBot.create(:second_task,user_id:task_user.id)
        visit tasks_path
        all('tr td')[7].click_on '詳細'
        expect(page).to have_content 'test_task_name'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面で「終了期限でソートする」をクリックした場合' do
      it '終了期限で降順でソートされたタスク一覧が表示される' do
        task_user = create_and_login(:task_user)
        task_old = FactoryBot.create(:task, name:'test_task_name_deadline_old',user_id:task_user.id)
        task_new = FactoryBot.create(:second_task, name:'test_task_name_deadline_new',user_id:task_user.id)
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

    context '一覧画面で「優先順位でソートする」をクリックした場合' do
      it '優先順位で降順でソートされたタスク一覧が表示される' do
        task_user = create_and_login(:task_user)
        task_middle = FactoryBot.create(:task, name:'test_task_name_priority_middle',priority:'middle',user_id:task_user.id)
        task_low = FactoryBot.create(:second_task, name:'test_task_name_priority_low',priority:'low',user_id:task_user.id)
        task_high = FactoryBot.create(:third_task, name:'test_task_name_priority_high',priority:'high',user_id:task_user.id)
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

    context '一覧画面の検索エリアで「タスク名」を入力して「検索」ボタンを押下した場合場合' do
      it 'タスク名のあいまい検索で絞り込まれたタスク一覧が表示される' do
        task_user = create_and_login(:task_user)
        task_old = FactoryBot.create(:task, name:'test_task_name_deadline_old',user_id:task_user.id)
        task_new = FactoryBot.create(:second_task, name:'test_task_name_search_result',user_id:task_user.id)
        visit tasks_path
        fill_in "search[name]", with: "search"
        click_on("検索")
        all('tr td')[7].click_on '詳細'
        expect(page).to have_content 'test_task_name_search_result'
      end
    end

    context '一覧画面の検索エリアで「ステータス」を入力して「検索」ボタンを押下した場合場合' do
      it 'ステータスで絞り込まれたタスク一覧が表示される' do
        task_user = create_and_login(:task_user)
        task_old = FactoryBot.create(:task, name:'test_task_name_status_working',user_id:task_user.id)
        task_new = FactoryBot.create(:second_task, name:'test_task_name_status_waiting',user_id:task_user.id)
        visit tasks_path
        select '着手中',from:'search[status]'
        click_on("検索")
        all('tr td')[7].click_on '詳細'
        expect(page).to have_content 'test_task_name_status_working'
      end
    end
    context '一覧画面の検索エリアで「タスク名」と「ステータス」を入力して「検索」ボタンを押下した場合場合' do
      it 'タスク名とステータスで絞り込まれたタスク一覧が表示される' do
        task_user = create_and_login(:task_user)
        task_first = FactoryBot.create(:task, name:'test_task_name_status_working',user_id:task_user.id)
        task_second = FactoryBot.create(:second_task, name:'test_task_name_result',user_id:task_user.id)
        task_third = FactoryBot.create(:third_task, name:'test_task_name_status_waiting',user_id:task_user.id)
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
        task_user = create_and_login(:task_user)
        visit new_task_path
        fill_in "task[name]", with: "detail_task_name"
        fill_in "task[content]", with: "detail_task_content"
        fill_in "task[deadline]", with: "00190001010000"
        click_on("登録する")
        click_on("詳細")
        expect(page).to have_content 'detail_task_name'
       end
     end
  end

  private
  def create_and_login(user)
    task_user = FactoryBot.create(user)
    visit new_session_path
    fill_in "session[email]", with: "t01@sample.jp"
    fill_in "session[password]", with: "12345678"
    click_on("Log in")
    return task_user
  end
end