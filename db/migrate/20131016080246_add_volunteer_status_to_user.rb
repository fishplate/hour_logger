class AddVolunteerStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :volunteer_status, :string
  end
end
