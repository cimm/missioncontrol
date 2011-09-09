module NavigationHelper
  def active(page)
    params[:controller] == page ? "active" : nil
  end
end
