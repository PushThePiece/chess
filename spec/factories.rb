FactoryGirl.define do 
  factory :user, aliases: [:white_player, :black_player] do
    sequence(:email) do |n|
      "dummyEmail#{n}@gmail.com"
    end
  password              "secretPassword"
  password_confirmation "secretPassword"
  end

  factory :game do
    white_player 
    turn          { white_user_id }
    black_player
    state         0
    winner        nil
  end
end