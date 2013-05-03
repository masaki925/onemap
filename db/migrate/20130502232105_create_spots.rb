class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.string :name, null:false
      t.string :address
      t.string :tel
      t.string :station
      t.integer :take_time
      t.float :cost

      t.timestamps
    end
  end
end
