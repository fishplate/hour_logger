module ApplicationHelper

  def display_login
    if !current_user
      link_to "Log In", new_user_session_path
    else
      link_to "Sign Out", destroy_user_session_path, confirm: 'Are you sure you want to logout?', :method => :delete
    end
  end

end
