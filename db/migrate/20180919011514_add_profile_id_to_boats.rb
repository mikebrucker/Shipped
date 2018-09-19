class AddProfileIdToBoats < ActiveRecord::Migration[5.2]
  def change
    add_reference :boats, :profile, foreign_key: true
  end
end
