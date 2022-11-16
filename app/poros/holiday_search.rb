require 'httparty'
require './app/poros/holiday'
require './app/service/holiday_service'

class HolidaySearch 
  def holidays
    service.holiday_call.map do |data|
      Holiday.new(data)
    end
  end

  def service 
    HolidayService.new
  end
end