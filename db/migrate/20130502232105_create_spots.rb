class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.string :name, null:false
      t.string :google_reference
      t.string :address
      t.string :tel
      t.string :station
      t.integer :take_time
      t.float :cost
      t.string :lat
      t.string :lng
      t.string :site_url
      t.string :image_url
      t.text   :description
      t.string :station

      t.timestamps
    end
  end
end
