FactoryBot.define do
  factory :admin_user, :class => 'User' do
    name { 'AdminUser' }
    email { 'admin@sample.jp' }
    password{'adminadmin'}
    password_confirmation{'adminadmin'}
    admin {true}
  end
  factory :common_user, :class => 'User'  do
    name { 'commonUser01' }
    email { 'c01@sample.jp' }
    password{'12345678'}
    password_confirmation{'12345678'}
    admin {false}
  end
end
