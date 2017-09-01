FactoryGirl.define do 
  factory :user do 
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
  password              "secretPassword"
  password_confirmation "secretPassword"
  end

  factory :game do
    black_user_id 1
    white_user_id 1
    turn          1
  end

end