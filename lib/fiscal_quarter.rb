class FiscalQuarter
  MONTH_FORMAT = "%m"
  START_MONTHS = { 1 => "1", 2 => "4", 3 => "7", 4 => "10" }
  END_MONTHS   = { 1 => "3", 2 => "6", 3 => "9", 4 => "12" }

  def initialize(quarter)
    @quarter = quarter
  end

  def starts_at
    start_month = START_MONTHS[@quarter]
    Date.strptime(start_month, MONTH_FORMAT)
  end

  def ends_at
    end_month = END_MONTHS[@quarter]
    Date.strptime(end_month, MONTH_FORMAT).end_of_month
  end
end
