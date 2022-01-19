require './app/poros/holiday_service' 

class HolidaySearch 

  def united_states_holiday_information 
    service.united_states.map do |holiday|
      Holiday.new(holiday)
    end
  end

  def three_upcoming_us_holidays 
    united_states_holiday_information.first(3)
  end

  def service 
    HolidayService.new
  end
end