class Shift < ApplicationRecord
  # a Shift is a User, working a particular Position for a given period
  MAX_HOURS_PER_WEEK = 40.to_f.freeze
  OPEN_FROM = 7.00
  OPEN_TILL = 3.00
  CLOSING_TIME = ((OPEN_TILL + 0.01)..(OPEN_FROM - 0.01))

  belongs_to :position
  belongs_to :user

  validates :position, :user, :start_at, :end_at, presence: true
  validate :duration_validation
  validate :max_hours_per_week
  validate :max_employees_per_shift
  validate :inside_working_hours


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

  def max_hours_per_week
    return unless user && end_at && start_at
    # assumes we are counting hours in the week they start, otherwise we could compare two weeks accidentally
    shifts_this_week = Shift.where(user_id: user.id).where(
      'start_at > ? AND start_at < ?', start_at.beginning_of_week, start_at.end_of_week
    ).where.not(id: self.id) # exclude self for updates

    hours_this_week = shifts_this_week.collect(&:duration_hours).sum

    if (duration_hours + hours_this_week) > MAX_HOURS_PER_WEEK
      errors.add(:end_at, "can't be more than the weekly #{MAX_HOURS_PER_WEEK} hour maximum")
    end
  end

  def max_employees_per_shift
    return unless position && end_at && start_at
    overlapping_shifts = Shift.where(
      'end_at > ? AND start_at < ?', start_at, end_at
    ).where.not(id: self.id).count # exclude self for updates
    if (overlapping_shifts + 1) > position.max_staff
      errors.add(:end_at, "can't overlap shifts. Too many shifts for the given period")
    end
  end

  def inside_working_hours
    return unless start_at && end_at
    return if start_at > end_at # validated elsewhere
    # shift could be 11pm to 3am, need to cover going into next day.
    # or 1am to 3am
    end_time = (end_at.hour.to_f + end_at.min.to_f / 60.0)
    start_time = (start_at.hour.to_f + start_at.min.to_f / 60.0)
    same_day = end_time > start_time


    # this was really complex when I tried to use whitelisted times, using blacklist times is much simpler.
    errors.add(:end_at, "can't be during closing hours") if CLOSING_TIME.include?(end_time)
    errors.add(:start_at, "can't be during closing hours") if CLOSING_TIME.include?(start_time)

    if same_day && (start_time < OPEN_TILL && end_time > OPEN_FROM)
      errors.add(:end_at, "can't be during closing hours")
      errors.add(:start_at, "can't be during closing hours")
    end
  end

end
