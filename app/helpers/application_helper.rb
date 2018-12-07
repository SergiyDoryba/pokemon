module ApplicationHelper
  def active_element_on_top_naviagation(nav_name)
    request.original_fullpath.include?(nav_name.downcase) ? 'active' : ''
  end
end
