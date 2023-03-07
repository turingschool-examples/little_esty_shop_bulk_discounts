require 'ostruct'

class NagerFacade

  def self.next_3_holidays
    holiday_list = {
      info: get_next_3_holidays
    }
    OpenStruct.new(holiday_list)
  end

  def self.get_next_3_holidays
    all_holidays = NagerService.fetch_api

    three_holidays = all_holidays[0..2].map do |holiday|
      { name: holiday[:name], 
        date: holiday[:date] }
    end
  end

end