class CreatePlandaySpots < ActiveRecord::Migration
  def change
    create_table :planday_spots do |t|
      t.references :planday
      t.references :spot

      t.timestamps
    end
    add_index :planday_spots, :planday_id
    add_index :planday_spots, :spot_id
  end
end
