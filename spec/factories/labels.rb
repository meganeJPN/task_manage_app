FactoryBot.define do
  factory :label_work, :class => 'Label' do
    name {'仕事'}
  end
  factory :label_study, :class => 'Label' do
    name {'勉強'}
  end
  factory :label_play, :class => 'Label' do
    name {'遊び'}
  end
  # factory :task_user, :class => 'User'  do
  #   name { 'taskUser01' }
  #   email { 't01@sample.jp' }
  #   password{'12345678'}
  #   password_confirmation{'12345678'}
  #   admin {false}
  # end
  factory :task_work, class: Task do
    # association :user, factory: :common_user
    name { 'test_work_task' }
    content { 'test_task_content' }
    status{'working'}
    priority{'high'}
    deadline {'2000-01-01 18:00:00'}
    user_id {''}
  end
  factory :task_work_wait_hw, class: Task do
    # association :user, factory: :common_user
    name { 'test_work_task' }
    content { 'test_task_content' }
    status{'wating'}
    priority{'high'}
    deadline {'2000-01-01 18:00:00'}
    user_id {''}
  end
  factory :task_work_wait_hp, class: Task do
    # association :user, factory: :common_user
    name { 'test_work_task' }
    content { 'test_task_content' }
    status{'wating'}
    priority{'high'}
    deadline {'2000-01-01 18:00:00'}
    user_id {''}
  end
  factory :task_study, class: Task do
    association :user
    name {'test_task_name_second'}
    content {'test_task_content_second'}
    status{'wating'}
    priority{'low'}
    deadline {'2010-01-01 18:00:00'}
    user_id{''}
  end
  factory :task_play, class: Task do
    association :user
    name {'test_task_name_third'}
    content {'test_task_content_second'}
    status{'wating'}
    priority{'low'}
    deadline {'2010-01-01 18:00:00'}
    user_id{''}
  end
  factory :task_work_same_name_w, class: Task do
    # association :user, factory: :common_user
    name { 'test_work_task' }
    content { 'test_task_content' }
    status{'wating'}
    priority{'high'}
    deadline {'2000-01-01 18:00:00'}
    user_id {''}
  end
  factory :task_work_same_name_s, class: Task do
    # association :user, factory: :common_user
    name { 'test_work_task' }
    content { 'test_task_content' }
    status{'working'}
    priority{'high'}
    deadline {'2000-01-01 18:00:00'}
    user_id {''}
  end
  factory :task_work_same_name_s_c, class: Task do
    # association :user, factory: :common_user
    name { 'test_work_task' }
    content { 'test_task_content' }
    status{'completed'}
    priority{'high'}
    deadline {'2000-01-01 18:00:00'}
    user_id {''}
  end
end
