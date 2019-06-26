FactoryBot.define do
  factory :user do
    sequence :first_name do |n|
      "Bob#{n}"
    end
    last_name { 'Squarepants' }

    sequence :email do |n|
      "sponge.bob_#{n}@google.com"
    end

    password { 'supersecret' }
    password_confirmation { 'supersecret' }
  end
end
