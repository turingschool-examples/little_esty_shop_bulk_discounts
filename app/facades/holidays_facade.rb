require './app/services/nager_service.rb'
require './app/poros/holiday.rb'

class HolidaysFacade
  def upcoming_holidays
    service.holidays[0..2].map do |holiday|
      Holiday.new(holiday)
    end
  end

  def service
    NagerService.new
  end
end