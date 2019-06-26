class Location < ApplicationRecord
  # Any Soho House location
  validates :name, presence: true, uniqueness: true
end
