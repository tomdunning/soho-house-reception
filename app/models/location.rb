class Location < ApplicationRecord
  # Any Soho House location
  OPENING_TIME = 7.00
  CLOSING_TIME = 3.00

  validates :name, presence: true, uniqueness: true
end
