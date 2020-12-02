User.create!(name:  "AdminUser",
  email: "admin@sample.jp",
  password:              "adminadmin",
  password_confirmation: "adminadmin",
  admin: true)

user01 = User.create!(name:  "Taro",
    email: "taro@sample.jp",
    password:              "12345678",
    password_confirmation: "12345678",
    admin: false)

user02 =  User.create!(name:  "Jiro",
    email: "jiro@sample.jp",
    password:              "12345678",
    password_confirmation: "12345678",
    admin: false)

user03 =   User.create!(name:  "Saburo",
    email: "saburo@sample.jp",
    password:              "12345678",
    password_confirmation: "12345678",
    admin: false)

label01 = Label.create!(name: "仕事")
label02 = Label.create!(name: "勉強")
label03 = Label.create!(name: "遊び")

100.times do |n|
  name  = "#{user01.name}のタスク#{n+1} "
  content = "#{user01.name}のコンテント#{n+1}"
  status = Task.statuses.invert.fetch(rand(3))
  priority = Task.priorities.invert.fetch(rand(3))
  deadline = DateTime.now - rand(1000)
  deadline.to_s(:db)
  task = Task.create!(name:  name,
               content: content,
               status: status,
               priority: priority,
               deadline: deadline,
              user_id: user01.id)
  Labelling.create(task_id: task.id, label_id: rand(3)+1)
end

100.times do |n|
  name  = "#{user02.name}のタスク#{n+1}"
  content = "#{user02.name}のコンテント#{n+1}"
  status = Task.statuses.invert.fetch(rand(3))
  priority = Task.priorities.invert.fetch(rand(3))
  deadline = DateTime.now - rand(1000)
  deadline.to_s(:db)
  task = Task.create!(name:  name,
               content: content,
               status: status,
               priority: priority,
               deadline: deadline,
               user_id: user02.id)
  Labelling.create(task_id: task.id, label_id: rand(3)+1)
end

100.times do |n|
  name  = "#{user03.name}のタスク#{n+1}"
  content = "#{user03.name}のコンテント#{n+1}"
  status = Task.statuses.invert.fetch(rand(3))
  priority = Task.priorities.invert.fetch(rand(3))
  deadline = DateTime.now - rand(1000)
  deadline.to_s(:db)
  task = Task.create!(name:  name,
               content: content,
               status: status,
               priority: priority,
               deadline: deadline,
               user_id: user03.id)
  Labelling.create(task_id: task.id, label_id: rand(3)+1)
end