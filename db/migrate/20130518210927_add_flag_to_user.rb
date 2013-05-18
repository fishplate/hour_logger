class AddFlagToUser < ActiveRecord::Migration
  def up
    add_column :users, :is_mentor, :boolean, :default => false
  end

  def down
    remove_column :users, :is_mentor
  end
end
