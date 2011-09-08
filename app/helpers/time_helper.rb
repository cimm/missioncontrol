module TimeHelper
  def formatted_hours(hours_to_format)
    distance_of_time_in_words(Time.now, Time.now + hours_to_format.hours)
  end
end
