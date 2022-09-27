class HolidayFacade
  def self.all_holidays
    data = DateNagerService.get_holidays
    holidays = data.map {|holiday_data| Holiday.new(holiday_data)}
  end

  def self.next_three
    all_holidays.sort_by{|holiday| holiday.date}.take(3)
  end

end