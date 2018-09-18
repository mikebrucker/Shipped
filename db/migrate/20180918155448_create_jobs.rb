class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.text :desc
      t.string :origin
      t.string :destination
      t.decimal :cost
      t.integer :containers

      t.timestamps
    end
  end
end
