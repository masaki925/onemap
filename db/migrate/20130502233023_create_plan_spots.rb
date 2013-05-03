class CreatePlanSpots < ActiveRecord::Migration
  def change
    create_table :plan_spots do |t|


      t.timestamps
    end
  end
end
