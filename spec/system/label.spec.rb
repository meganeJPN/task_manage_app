require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能(ラベル)' do
    context 'タスクを新規作成した場合' do
      it 'ラベルを登録できる' do
        task_user = FactoryBot.create(:task_user)
        init_label
        visit new_session_path
        fill_in "session[email]", with: "t01@sample.jp"
        fill_in "session[password]", with: "12345678"
        click_on("Log in")
        click_on("新規タスクの作成")
        fill_in "task[name]", with: "new_task_name"
        fill_in "task[content]", with: "new_task_content"
        check '仕事'
        fill_in "task[deadline]", with: "00190001010000"
        click_on("登録する")
        expect(page).to have_content '仕事'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '一覧画面にタスクに設定したラベルが表示されている' do
        task_user = create_and_login(:task_user)
        labels = init_label
        task_work = FactoryBot.create(:task_work, name:'task', user_id: task_user.id)
        FactoryBot.create(:labelling, task: task_work, label: labels[:work])
        visit tasks_path
        expect(find(".table")).to have_content '仕事'
        expect(find(".table")).to_not have_content '遊び'
        expect(find(".table")).to_not have_content '勉強'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面の検索エリアで「ラベル」を入力して「検索」ボタンを押下した場合' do
      it 'ラベルで絞り込まれたタスク一覧が表示される' do
        task_user = create_and_login(:task_user)
        task_work = FactoryBot.create(:task_work, user_id: task_user.id)
        task_study = FactoryBot.create(:task_study, user_id: task_user.id)
        labels = init_label
        FactoryBot.create(:labelling, task: task_work, label: labels[:work])
        FactoryBot.create(:labelling, task: task_study, label: labels[:study])
        visit tasks_path
        select '勉強',from:'search[label_id]'
        click_on("検索")
        all('tr td')[8].click_on '詳細'
        expect(page).to have_content '勉強'
        expect(page).to_not have_content '仕事'
        expect(page).to_not have_content '遊び'
      end
    end
    context '一覧画面の検索エリアで「ステータス」と「ラベル」を入力して「検索」ボタンを押下した場合場合' do
      it 'ステータスとラベルで絞り込まれたタスク一覧が表示される' do
        task_user = create_and_login(:task_user)
        task_work = FactoryBot.create(:task_work, user_id:task_user.id)
        task_work_wait_hw = FactoryBot.create(:task_work_wait_hw, user_id:task_user.id)
        task_work_wait_hp = FactoryBot.create(:task_work_wait_hp, user_id:task_user.id)
        labels = init_label
        FactoryBot.create(:labelling, task: task_work, label: labels[:work])
        FactoryBot.create(:labelling, task: task_work_wait_hw, label: labels[:work])
        FactoryBot.create(:labelling, task: task_work_wait_hp, label: labels[:play])
        visit tasks_path
        # binding.irb
        select '未着手',from:'search[status]'
        # binding.irb
        select '仕事',from:'search[label_id]'
        click_on("検索")
        # binding.irb
        expect(find(".table")).to have_content '未着手'
        expect(find(".table")).to have_content '仕事'
        expect(find(".table")).to_not have_content '遊び'
        expect(find(".table")).to_not have_content '勉強'
        expect(find(".table")).to_not have_content '着手中'
        expect(find(".table")).to_not have_content '完了'
      end
    end
    context '一覧画面の検索エリアで「タスク名」と「ラベル」を入力して「検索」ボタンを押下した場合場合' do
      it 'タスク名とラベルで絞り込まれたタスク一覧が表示される' do
        task_user = create_and_login(:task_user)
        task_work_same_name_w = FactoryBot.create(:task_work_same_name_w, user_id:task_user.id)
        task_work_same_name_s = FactoryBot.create(:task_work_same_name_s, user_id:task_user.id)
        task_work_play = FactoryBot.create(:task_play, user_id:task_user.id)
        labels = init_label
        FactoryBot.create(:labelling, task: task_work_same_name_w, label: labels[:work])
        FactoryBot.create(:labelling, task: task_work_same_name_s, label: labels[:study])
        FactoryBot.create(:labelling, task: task_work_play, label: labels[:play])
        visit tasks_path
        fill_in "search[name]", with: "work_task"
        select '勉強',from:'search[label_id]'
        click_on("検索")
        expect(find(".table")).to_not have_content 'test_task_name'
        expect(find(".table")).to have_content 'work_task'
        expect(find(".table")).to have_content '勉強'
      end
    end
    context '一覧画面の検索エリアで「タスク名」と「ステータス」と「ラベル」を入力して「検索」ボタンを押下した場合場合' do
      it 'タスク名とステータスとラベルで絞り込まれたタスク一覧が表示される' do
        task_user = create_and_login(:task_user)
        task_work_same_name_w = FactoryBot.create(:task_work_same_name_w, user_id:task_user.id)
        task_work_same_name_s = FactoryBot.create(:task_work_same_name_s, user_id:task_user.id)
        task_work_same_name_s_c = FactoryBot.create(:task_work_same_name_s_c, user_id:task_user.id)
        task_work_play = FactoryBot.create(:task_play, user_id:task_user.id)
        labels = init_label
        FactoryBot.create(:labelling, task: task_work_same_name_w, label: labels[:work])
        FactoryBot.create(:labelling, task: task_work_same_name_s, label: labels[:study])
        FactoryBot.create(:labelling, task: task_work_same_name_s_c, label: labels[:study])
        FactoryBot.create(:labelling, task: task_work_play, label: labels[:play])
        visit tasks_path
        fill_in "search[name]", with: "work_task"
        select '勉強',from:'search[label_id]'
        select '完了',from:'search[status]'
        click_on("検索")
        expect(find(".table")).to have_content 'work_task'
        expect(find(".table")).to have_content '勉強'
        expect(find(".table")).to have_content '完了'
        expect(find(".table")).to_not have_content '遊び'
        expect(find(".table")).to_not have_content '仕事'
        expect(find(".table")).to_not have_content '着手中'
        expect(find(".table")).to_not have_content '未着手'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容（ラベル）が表示される' do
        task_user = create_and_login(:task_user)
        labels = init_label
        task_work = FactoryBot.create(:task_work, name:'task', user_id: task_user.id)
        FactoryBot.create(:labelling, task: task_work, label: labels[:work])
        visit tasks_path
        all('tr td')[8].click_on '詳細'
        expect(page).to have_content '仕事'
       end
     end
  end

  describe '編集機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容（ラベル）を編集できる' do
        task_user = create_and_login(:task_user)
        labels = init_label
        task_work = FactoryBot.create(:task_work, name:'task', user_id: task_user.id)
        FactoryBot.create(:labelling, task: task_work, label: labels[:work])
        visit tasks_path
        all('tr td')[9].click_on '編集'
        check '遊び'
        uncheck '仕事'
        click_on("登録する")
        all('tr td')[8].click_on '詳細'
        expect(page).to have_content '遊び'
        expect(page).to_not have_content '仕事'
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
  def init_label
    label_work = FactoryBot.create(:label_work)
    label_study = FactoryBot.create(:label_study)
    label_play = FactoryBot.create(:label_play)
    labels = {work: label_work, study: label_study, play: label_play}
  end
end