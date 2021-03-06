# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, #:registerable, - not registerable, admin creation only
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true

  def name
    "#{first_name} #{last_name}"
  end
end
