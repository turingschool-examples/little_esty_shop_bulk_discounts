require './app/services/holidays_service.rb'
require 'json'
require './app/poros/holidays.rb'
require 'httparty'

class HolidaysBuilder
  def self.service
    HolidaysService.new
  end

  def self.holiday_info
    Holidays.new(service.holidays)
  end
end

