class AddNumberOfParticipantsToUserHour < ActiveRecord::Migration
  def change
    add_column :user_hours, :number_participants, :integer
    add_column :user_hours, :new_participants, :integer
  end
end
