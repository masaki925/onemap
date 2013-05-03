class CreatePlandays < ActiveRecord::Migration
  def change
    create_table :plandays do |t|
      t.references :plan, null:false
      t.integer :day, null:false

      t.timestamps
    end
    add_index :plandays, :plan_id
  end
end
