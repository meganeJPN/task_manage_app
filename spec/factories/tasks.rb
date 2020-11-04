FactoryBot.define do
  factory :task_user, :class => 'User'  do
    name { 'taskUser01' }
    email { 't01@sample.jp' }
    password{'12345678'}
    password_confirmation{'12345678'}
    admin {false}
  end
  factory :task do
    # association :user, factory: :common_user
    name { 'test_task_name' }
    content { 'test_task_content' }
    status{'working'}
    priority{'high'}
    deadline {'2000-01-01 18:00:00'}
    user_id {''}
  end
  
  factory :second_task, class: Task do
    association :user
    name {'test_task_name_second'}
    content {'test_task_content_second'}
    status{'wating'}
    priority{'low'}
    deadline {'2010-01-01 18:00:00'}
    user_id{''}
  end
  factory :third_task, class: Task do
    association :user
    name {'test_task_name_third'}
    content {'test_task_content_second'}
    status{'wating'}
    priority{'low'}
    deadline {'2010-01-01 18:00:00'}
    user_id{''}
  end
  factory :fourth_task, class: Task do
    association :user
    name {'test_task_name_third'}
    content {'test_task_content_second'}
    status{'working'}
    priority{'low'}
    deadline {'2010-01-01 18:00:00'}
    user_id{''}
  end
end
