class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.references :boat, foreign_key: true
      t.references :job, foreign_key: true
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
