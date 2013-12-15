ActiveAdmin.register User do
  menu :priority => 4
  index do
    selectable_column
    column :email
    column :first_name
    column :last_name
    column :gender
    column :date_of_birth
    column :contact_number
    column :mentor
    column :is_mentor
    default_actions
  end

  form do |f|
    f.inputs do
      collection = Mentor.all
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :gender
      f.input :date_of_birth
      f.input :contact_number
      f.input :mentor, :as => :select, :collection => collection
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :first_name
      row :last_name
      row :gender
      row :date_of_birth
      row :contact_number
      row :mentor
      row :is_mentor
    end
      active_admin_comments
  end

  member_action :make_mentor do
    if User.find(params[:id]).make_mentor
      redirect_to(admin_users_path, :notice => "Mentor created")
    else
      notice = 'Error creating mentor! Please check first and last name present'
      redirect_to(admin_users_path, :notice => notice)
    end
  end

  member_action :remove_mentor do
    User.find(params[:id]).remove_mentor
    redirect_to(admin_users_path, :notice => "Mentor removed")
  end

  action_item :only => :show do
    if user.is_mentor?
      link_to "Remove Mentor", remove_mentor_admin_user_path(user)
    else
      link_to "Make Mentor", make_mentor_admin_user_path(user)
    end
  end
end