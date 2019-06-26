class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.references :location
      t.string :name
      t.integer :min_staff, default: 1
      t.integer :max_staff, default: 1
      t.float :min_shift_duration_hrs
      t.float :max_shift_duration_hrs

      t.timestamps
    end
  end
end
