class AddMaleToUserHours < ActiveRecord::Migration
  def change
    add_column :user_hours, :number_participants_male, :integer
    add_column :user_hours, :number_participants_female, :integer
    add_column :user_hours, :new_participants_male, :integer
    add_column :user_hours, :new_participants_female, :integer
    remove_column :user_hours, :new_participants
    remove_column :user_hours, :number_participants
  end
end
