FactoryBot.define do
  factory :shift do
    association :position
    association :user

    start_at { Time.now.tomorrow.beginning_of_day + 8.hours }
    end_at { Time.now.tomorrow.beginning_of_day + 12.hours }
  end
end
