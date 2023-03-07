require "./app/services/holiday_service.rb"
require "./app/poros/holiday.rb"

class HolidayFacade
  def upcoming_holidays
    service.holidays[0..2].map do |holiday|
      Holiday.new(holiday)
    end
  end

  def service
    HolidayService.new
  end
end