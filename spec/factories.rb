FactoryGirl.define do 
  factory :user, aliases: [:white_player] do
    sequence(:email) do |n|
      "dummyEmail#{n}@gmail.com"
    end
    # sequence(:email, 'A', aliases: [:black_player]) do |n|
    #   "dummyEmail#{n}@gmail.com"
    # end
  password              "secretPassword"
  password_confirmation "secretPassword"
  end

  factory :game do
    white_player 
    turn { white_user_id }
   

    # factory :update_game do
    #   black_player 
    # end
    
    # association  :white_player, factory: :user
    # association  :black_player, factory: :email 
  # end

#   factory :user do
#     sequence :email do |n|
#       "dummyEmail#{n}@gmail.com"
#     end
#  password              "secretPassword"
#   password_confirmation "secretPassword"
# end
end
end