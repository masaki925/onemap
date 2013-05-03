class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :title, default: ""
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.boolean :valid_f, default: true

      t.timestamps
    end
  end
end
