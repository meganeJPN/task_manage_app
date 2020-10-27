100.times do |n|
  name  = "example-#{n+1}"
  content = "example-#{n+1}のコンテント"
  status = Task.statuses.invert.fetch(rand(3))
  priority = Task.priorities.invert.fetch(rand(3))
  deadline = DateTime.now - rand(1000)
  deadline.to_s(:db)
  Task.create!(name:  name,
               content: content,
               status: status,
               priority: priority,
               deadline: deadline)
end