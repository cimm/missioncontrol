require "fiscal_quarter"

module NavigationHelper
  def active(page)
    params[:controller] == page ? "active" : nil
  end

  def fiscal_quarter_path(quarter)
    fiscal_quarter = FiscalQuarter.new(quarter)
    date_range     = "#{fiscal_quarter.starts_at}to#{fiscal_quarter.ends_at}"
    expenses_path(:date_range => date_range)
  end
end
