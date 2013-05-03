class CreatePlandaySpots < ActiveRecord::Migration
  def change
    create_table :planday_spots do |t|
      t.references :planday, null:false
      t.references :spot, null:false

      t.timestamps
    end
    add_index :planday_spots, :planday_id
    add_index :planday_spots, :spot_id
  end
end
