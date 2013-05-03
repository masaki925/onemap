class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :title, null:false
      t.references :user, null:false
      t.date :start_datetime
      t.date :end_datetime
      t.boolean :valid_f, default: true

      t.timestamps
    end
  end
end
