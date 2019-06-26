# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address_line_1
      t.string :address_line_2
      t.string :postcode
      t.string :country_code

      t.timestamps
    end
  end
end
