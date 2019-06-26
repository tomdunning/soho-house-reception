# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    sequence :name do |n|
      "Location #{n}"
    end

    trait :with_address do
      address_line_1 { '123 Fake Street' }
      address_line_2 { 'York' }
      postcode { 'YO26 5TB' }
      country_code { 'GBR' }
    end
  end
end
