class ChangeDateFieldToTextUser < ActiveRecord::Migration
  def up
  	change_column :users, :date_of_birth, :text
  end

  def down
  	change_column :users, :date_of_birth, :date
  end
end
