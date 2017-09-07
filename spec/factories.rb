FactoryGirl.define do 
  factory :user, aliases: [:white_player, :black_player]do 
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
  password              "secretPassword"
  password_confirmation "secretPassword"
  end

  factory :game do

    white_user_id 1
    black_user_id 2
    turn          1
    
    association  :white_player, factory: :user  
  end

end