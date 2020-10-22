require 'rails_helper'
require 'database_cleaner'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '失敗テスト', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: '成功テスト', content: '成功テスト')
        expect(task).to be_valid
      end
    end
  end
  describe "検索機能" do
    let!(:task) {FactoryBot.create(:task, name:'test_task_name_status_working')}
    let!(:second_task) { FactoryBot.create(:second_task, name:'test_task_name_result')}
    let!(:third_task) {FactoryBot.create(:third_task, name:'test_task_name_status_waiting')}
    let!(:fourth_task) {FactoryBot.create(:fourth_task, name:'test_task_name_status_result')}

    context 'scopeメソッドのタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り理こまれる" do
        # binding.irb
        expect(Task.name_like('wait')).to include(third_task)
        expect(Task.name_like('wait')).to_not include(task,second_task,fourth_task)
        expect(Task.name_like('wait').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_is('1')).to include(task,fourth_task)
        expect(Task.status_is('1')).to_not include(second_task,third_task)
        expect(Task.status_is('1').count).to eq 2
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        search_params = {name:"res",status:"1"}
        expect(Task.search(search_params)).to include(fourth_task)
        expect(Task.search(search_params)).to_not include(task,second_task,third_task)
        expect(Task.search(search_params).count).to eq 1
      end
    end
  end
  
end