# frozen_string_literal: true

class Position < ApplicationRecord
  # a Position is a Role, at a particular Location, such as the receptionist as Babington House
  belongs_to :location

  validates :location, :name, presence: true
  validates :min_shift_duration_hrs, :max_shift_duration_hrs, numericality: { greater_than: 0 }

  validate :sane_shift_duration_limits

  private

  def sane_shift_duration_limits
    return unless max_shift_duration_hrs && min_shift_duration_hrs

    if max_shift_duration_hrs < min_shift_duration_hrs
      errors.add(:max_shift_duration_hrs, "can't be less than the minimum")
    end
  end
end
