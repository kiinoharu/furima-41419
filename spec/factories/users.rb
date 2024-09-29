FactoryBot.define do
  factory :user do
    nickname              { 'testuser' }
    first_name            { '太郎' }
    last_name             { '山田' }
    first_name_kana       { 'タロウ' }
    last_name_kana        { 'ヤマダ' }
    date_of_birth         { '1990-01-01' }
    email                 { 'test@example.com' }
    password              { 'password123' }
    password_confirmation { password }
  end
end
