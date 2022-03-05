class HolidayFacade
  def self.get_holiday
    response = HolidayService.find_holiday
    response.shift(3).map { |holiday| Holiday.new(holiday) }
  end
end
