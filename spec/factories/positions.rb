FactoryBot.define do
  factory :position do
    association :location

    name { "Receptionist" }

    min_shift_duration_hrs { 1.0 }
    max_shift_duration_hrs { 8.0 }
  end
end
