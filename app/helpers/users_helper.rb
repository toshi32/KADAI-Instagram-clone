module UsersHelper
  def user_url_confirm
    if action_name == 'new' || action_name == 'create' || action_name == 'confirm'
      confirm_users_path
    elsif action_name == 'edit' || action_name == 'update'
      confirm_user_path
    end
  end

  def user_edit_confirm
    unless @user.id
      users_path
    else
      user_path
    end
  end

  def user_method_confirm
    @user.id ? 'patch' : 'post'
  end
end