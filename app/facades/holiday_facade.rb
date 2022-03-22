class HolidayFacade
  class << self
    def country_holidays(country)
      holidays = HolidayService.holidays(country)[0..2]
      holidays.map do |holiday|
        Holiday.new(holiday)
      end
    end
  end
end