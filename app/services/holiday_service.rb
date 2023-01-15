require 'httparty'
require 'date'

class HolidayService
  def self.get_holidays
    response = connection('PublicHolidays/2023/US')
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_next_three_holidays
    holidays = get_holidays
    three_holidays = Array.new
    holidays.each do |holiday|
      return three_holidays if three_holidays.count == 3
      if Date.parse(holiday[:date]) > Date.today
        three_holidays << holiday
      end
    end
  end

  def self.name_and_date_next_three_holidays
    holidays = get_next_three_holidays
    holidays.map do |holiday|
      "#{holiday[:localName]}: #{holiday[:date]}"
    end
  end

  private
  
  def self.connection(uri)
    base_url = "https://date.nager.at/api/v3/"
    url = base_url + uri
    HTTParty.get(url)
  end
end