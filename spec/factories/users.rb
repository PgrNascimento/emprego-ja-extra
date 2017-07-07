FactoryGirl.define do
  factory :user do
    email
    password 'alanalan'
  end

  sequence :email do |n|
    "alan#{n}@teste.com"
  end
end
