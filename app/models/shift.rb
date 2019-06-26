class Shift < ApplicationRecord
  # a Shift is a User, working a particular Position for a given period
  MAX_HOURS_PER_WEEK = 40.to_f.freeze

  belongs_to :position
  belongs_to :user

  validates :position, :user, :start_at, :end_at, presence: true
  validate :duration_validation


  def duration
    end_at - start_at
  end

  def duration_hours
    duration / 3600
  end

  private

  def duration_validation
    return unless position && end_at && start_at

    if start_at > end_at
      errors.add(:end_at, "must be after the start of your shift")
      return
    end

    if duration_hours < position.min_shift_duration_hrs
      errors.add(:end_at, "can't be shorter than the minimum shift duration: #{position.min_shift_duration_hrs} hrs")
    end
    if duration_hours > position.max_shift_duration_hrs
      errors.add(:end_at, "can't be longer than the maximum shift duration: #{position.max_shift_duration_hrs} hrs")
    end
  end

end
