FactoryBot.define do
  factory :task do
    name { 'test_task_name' }
    content { 'test_task_content' }
    deadline {'2000/01/01'}
  end

  factory :second_task, class: Task do
    name {'test_task_name_second'}
    content {'test_task_content_second'}
    deadline {'2010/01/01'}
  end
end