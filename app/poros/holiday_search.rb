require "httparty"
require "./app/poros/holiday"
require "./app/services/holiday_service"

class HolidaySearch
  def holiday_info
    service.holiday.map do |data|
      Holiday.new(data)
    end
  end

  def service
    HolidayService.new
  end
end
