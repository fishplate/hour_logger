class CreateUserWhiteLists < ActiveRecord::Migration
  def change
    create_table :user_white_lists do |t|
      t.string :email
      t.timestamps
    end
  end
end
