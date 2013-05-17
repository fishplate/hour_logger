class Addflagtouserhours < ActiveRecord::Migration
  def up
    add_column :user_hours, :archived, :boolean, :default => false
    add_column :user_hours, :confirmed, :boolean, :default => false
  end

  def down
    remove_column :user_hours, :archived
    remove_column :user_hours, :confirmed
  end
end
