# frozen_string_literal: true

class Location < ApplicationRecord
  # Any Soho House location

  validates :name, presence: true, uniqueness: true
end
