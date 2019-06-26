class Position < ApplicationRecord
  # a Position is a Role, at a particular Location, such as the receptionist as Babington House

  belongs_to :location

  validates :location, :name, presence: true
end
