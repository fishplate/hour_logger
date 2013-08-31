module ApplicationHelper

  def display_login
    if !current_user
      link_to "Log In", new_user_session_path
    else
      link_to "Sign Out", destroy_user_session_path, confirm: 'Are you sure you want to logout?', :method => :delete
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
