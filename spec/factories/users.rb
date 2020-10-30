FactoryBot.define do
  factory :user do
    name { 'AdminUser' }
    email { 'admin@sample.jp' }
    password{'adminadmin'}
    password_confirmation{'adminadmin'}
    admin {true}
  end
end
