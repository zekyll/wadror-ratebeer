FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Psw1"
    password_confirmation "Psw1"
    admin true
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name "anonymous"
    year 1900
  end

  factory :beer do
    name "anonymous"
    brewery
    style "Lager"
  end
end