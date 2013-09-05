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

  def full_name
    if current_user.first_name && current_user.last_name
      current_user.first_name + " " + current_user.last_name
    else
      current_user.email
    end
  end

  def salutation
    time = Time.now.to_i
    if time < 12
     "Good Morning"
    else
     "Good Afternoon"
    end
  end

end
