FactoryBot.define do
  factory :position do
    association :location

    name { "Receptionist" }

    min_shift_duration_hrs { 1.0 }
    max_shift_duration_hrs { 8.0 }
    max_staff { 1 }
    min_staff { 1 }
  end
end
