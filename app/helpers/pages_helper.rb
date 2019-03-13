module PagesHelper

  def can_current_user_manage_page?(page)
    PageAccessPermission.can_manage?(current_user, page)
  end

end
