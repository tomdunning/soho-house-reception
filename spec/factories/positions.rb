FactoryBot.define do
  factory :position do
    association :location

    name { "Receptionist" }
  end
end
