class DateRange
  DATE_FORMAT      = "%Y-%m-%d"
  DATE_SPLIT_TOKEN = "to"

  def initialize(range)
    @range = range
  end

  def start_date
    start_date_part = split_in_start_and_end_date.first
    Date.strptime(start_date_part, DATE_FORMAT)
  end

  def end_date
    end_date_part = split_in_start_and_end_date.last
    Date.strptime(end_date_part, DATE_FORMAT)
  end

  def split_in_start_and_end_date
    @range.split(DATE_SPLIT_TOKEN)
  end
end
