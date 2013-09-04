ActiveAdmin.register UserHour do
  menu :priority => 5
  index do
    selectable_column
    column :hours
    column :placement
    column :archived
    column :confirmed
    column :user
    default_actions
  end
end