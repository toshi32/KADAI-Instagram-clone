module BlogsHelper
  def url_confirm
    if action_name == 'new' || action_name == 'create' || action_name == 'confirm'
      confirm_blogs_path
    elsif action_name == 'edit' || action_name == 'update'
      confirm_blog_path
    end
  end

  def edit_confirm
    unless @blog.id
      blogs_path
    else
      blog_path
    end
  end

  def method_confirm
    @blog.id ? 'patch' : 'post'
  end
end