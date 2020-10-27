FactoryBot.define do
  factory :task do
    name { 'test_task_name' }
    content { 'test_task_content' }
    status{'working'}
    priority{'high'}
    deadline {'2000-01-01 18:00:00'}
  end
  
  factory :second_task, class: Task do
    name {'test_task_name_second'}
    content {'test_task_content_second'}
    status{'wating'}
    priority{'low'}
    deadline {'2010-01-01 18:00:00'}
  end
  factory :third_task, class: Task do
    name {'test_task_name_third'}
    content {'test_task_content_second'}
    status{'wating'}
    priority{'low'}
    deadline {'2010-01-01 18:00:00'}
  end
  factory :fourth_task, class: Task do
    name {'test_task_name_third'}
    content {'test_task_content_second'}
    status{'working'}
    priority{'low'}
    deadline {'2010-01-01 18:00:00'}
  end
end
