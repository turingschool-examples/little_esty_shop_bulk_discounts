require 'httparty'
require 'json'
require 'pry'
require_relative '/Users/gls/Turing/2module/finals/little_esty_shop_bulk_discounts/app/poros/hoiday.rb'

class HolidayService
  def self.holiday
    response = HTTParty.get('https://date.nager.at/api/v3/NextPublicHolidays/US')
    parsed_holidays = JSON.parse(response.body, symbolize_names: true)[0..2]
    Holiday.get(parsed_holidays)
  end
end
