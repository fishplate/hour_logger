module ApplicationHelper

  def display_login
    if !current_user
      link_to "Log In", new_user_session_path, :class => "links"
    else
      link_to "Sign Out", destroy_user_session_path, confirm: 'Are you sure you want to logout?', :method => :delete, :class => "links"
    end
  end

end
