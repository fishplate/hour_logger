class CreateUserHours < ActiveRecord::Migration
  def change
    create_table :user_hours do |t|
      t.integer :user_id
      t.float :hours
      t.integer :placement_id
      t.date :date_occurred

      t.timestamps
    end
  end
end
