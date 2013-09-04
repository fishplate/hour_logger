ActiveAdmin.register Mentor do
  menu :priority => 3
  index do
    selectable_column
    column :first_name
    column :last_name
    column :email
    default_actions
  end

end